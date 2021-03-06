Install Homebrew
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
Choose install yes if prompted to install Xcode command line tools.

Update Homebrew
```
$ brew update
```
Install rbenv
```
$ brew install rbenv
```
Add ~/.rbenv/bin to your $PATH for access to the rbenv command-line utility.
```
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
```
Add rbenv init to your shell to enable shims and autocompletion.
```
$ echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
```
Restart your shell so that PATH changes take effect. Opening a new terminal tab will usually do it.

Install ruby 2.3.0
```
$ rbenv install 2.3.0
```
Set global version of Ruby to 2.3.0
```
$ rbenv global 2.3.0
```
Update RubyGems (you may need to use sudo)
```
$ gem update --system
```
Install Bundler
```
$ gem install bundler
```
Install Rails
```
$ gem install rails
```
Install shims for all Ruby executables
```
$ rbenv rehash
```
Install git
```
$ brew install git
```

## Starting the web server
```
$ cd ~/healthpod-web
$ RAILS_ENV=production rake assets:precompile
$ RAILS_ENV=production rake db:migrate
$ rails s -e production
```
