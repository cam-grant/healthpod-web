require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Kiosk
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    ###### Health Pod config ######
    config.x.session_timeout = 90000 # Milliseconds
    config.x.session_timeout_warning = 30000 # Milliseconds
    config.x.printer_name = "Canon_iP110_series"
    config.x.reports_folder = "/tmp"
    config.x.data_export_folder = "~/Desktop/HealthPodData/"
    config.x.enable_bmi_scales = true
    config.x.usb_serial_port = "/dev/tty.usbserial"
    config.x.usb_serial_port_timeout = 30 # Seconds
    config.x.max_bmi_scale_retries = 2

    # Time zone
    config.time_zone = 'Canberra'

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.autoload_paths << Rails.root.join('pdf')
  end
end
