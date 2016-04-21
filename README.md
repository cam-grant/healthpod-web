# Health Pod software configuration guide
## Ruby, Rails and Gems

* Ruby 2.3.0
* Rails 4.2.5

Additional gems:

* serialport 1.3.1 - serial port comms with the BMI scales
* prawn 2.1.0 - PDF health report generation

## launchd

Webrick server is automatically started via launchd

* See au.com.ochre.healthpod.plist under ~/Library/LaunchAgents

## Javascript and jQuery plug-ins

* jQuery
* Touch scrolling for jQuery: https://github.com/davetayls/jquery.kinetic
* Touch keyboard for jQuery: https://github.com/chriscook/on-screen-keyboard

## Application configuration

See config/application.config for the following settings:

* session_timeout = 90000 # Milliseconds
* session_timeout_warning = 30000 # Milliseconds
* printer_name = "Canon_iP110_series"
* reports_folder = "/tmp"
* data_export_folder = "~/Desktop/HealthPodData/"
* enable_bmi_scales = true
* usb_serial_port = "/dev/tty.usbserial"
* usb_serial_port_timeout = 30 # Seconds
* max_bmi_scale_retries = 2

# Hardware
## ACER Touchscreen

* Resolution: 1080p (1920 x 1080)
* Equivalent to approx. 2048 x 1152 on an Apple cinema display (for dev purposes)

## Canon printer

* Printer is a Canon PIXMA iP110
* The spare black ink cartridges are labelled “35 Black (PGI-35 Black)” and the colour cartridges “36 Color (CLI-36 Color)”
