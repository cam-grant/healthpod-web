# Health Pod software configuration guide

## Applications

The Health Pod consists of two software applications:

* A Ruby on Rails (http://rubyonrails.org) web application
* An Electron (http://electron.atom.io) desktop app

The desktop app loads the rails app (http://localhost:3000) in a Chromium shell and enters full screen mode.

The web app is installed to:
```
/Users/healthpod/healthpod-web/
```

The desktop app to:
```
/Users/healthpod/Desktop/
```

## Data export

Data export is available by visiting:
```
http://localhost:3000/data
```

All data is exported to:
```
/Users/healthpod/Desktop/HealthPodData/
```


## Ruby, Rails and Gems

The web app requires:

* Ruby 2.3.0
* Rails 4.2.5

Additional gems:

* serialport 1.3.1 - serial port comms with BMI scales
* prawn 2.1.0 - PDF health report generation

## launchd

Webrick server is automatically started (RAILS_ENV=production) on machine boot via launchd. See ```au.com.ochre.healthpod.plist``` in ```~/Library/LaunchAgents``` for launch settings.

## Javascript, jQuery and plug-ins

* jQuery
* Touch scrolling for jQuery (https://github.com/davetayls/jquery.kinetic)
* Touch keyboard for jQuery (https://github.com/chriscook/on-screen-keyboard)

## Web application configuration

See config/application.config for app specific settings:

* session_timeout = 90000 # Milliseconds
* session_timeout_warning = 30000 # Milliseconds
* printer_name = "Canon_iP110_series"
* reports_folder = "/tmp"
* data_export_folder = "~/Desktop/HealthPodData/"
* enable_bmi_scales = true
* usb_serial_port = "/dev/tty.usbserial"
* usb_serial_port_timeout = 30 # Seconds
* max_bmi_scale_retries = 2

# Hardware notes
## ACER Touchscreen

The web app's layout, font-sizes, etc. are specifically designed for the ACER Touchscreen's resolution of 1080p (1920 x 1080). 1080p is roughly equivalent to 2048 x 1152 on an Apple cinema display (for development purposes).

## Canon printer

Printer is a Canon PIXMA iP110.

Spare black ink cartridges are labelled “35 Black (PGI-35 Black)” and the colour cartridges “36 Color (CLI-36 Color)”
