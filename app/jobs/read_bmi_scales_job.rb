class ReadBmiScalesJob < ActiveJob::Base

  require 'serialport'

  USB_SERIAL_PORT = Rails.configuration.usb_serial_port # /dev/tty.usbserial
  SERIAL_READ_TIMEOUT = Rails.configuration.usb_serial_port_timeout # Seconds
  SERIAL_DATA_EOF = "\n\n\n\n\n"

  queue_as :default

  def self.reset_scales
    begin
      sp = SerialPort.new USB_SERIAL_PORT
      sp.write "C\r\n" # Clear scales
      # sp.write "Z\r\n" # Zeroing the scales seems to create problems
    rescue IO::WaitWritable
      IO.select(nil, [sp])
      retry
    rescue
    ensure
      if sp
        sp.close
        sp = nil
      end
    end
  end

  def parse_data(data)
    data.scan /\d+\.?\d*/
  end

  def perform(user_data)
    logger.info "Start ReadBmiScalesJob"

    # Encoding.default_external = Encoding::UTF_8
    # Encoding.default_internal = Encoding::UTF_8

    user_data.update_attributes weight: nil, height: nil, bmi: nil, bmi_recorded_at: nil

    start_time = Time.now
    buffer = ""
    keep_reading = true

    begin
      sp = SerialPort.new USB_SERIAL_PORT
      logger.info "Opened #{USB_SERIAL_PORT}"

      while keep_reading do
        begin
          buffer << sp.read_nonblock(1) # sp.getc blocks
          if buffer.include? SERIAL_DATA_EOF
            # Parse data
            data = parse_data(buffer)
            user_data.update_attributes weight: data[2], height: data[3], bmi: data[4], bmi_recorded_at: Time.now

            # Done
            keep_reading = false
            logger.info "User data updated"
          end

        rescue IO::WaitReadable
          if (Time.now - start_time) > SERIAL_READ_TIMEOUT
            logger.info "TO"
            if sp
              begin
                sp.close
                sp = nil
              rescue
              end
            end
            return
          else
            sleep 1
          end

          # logger.warn "IO::WaitReadable"
          # IO.select([sp])
          retry
        rescue IO::WaitWritable
          # logger.warn "IO::WaitWritable"
          # IO.select(nil, [sp])
          retry
        end
      end

    rescue => e
      logger.fatal e.to_s
    end

    logger.info "End ReadBmiScalesJob"
  end
end
