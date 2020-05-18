#!/usr/bin/env bash

set -o pipefail

echo 'Starting...';

# Check to see if Homebrew is installed, and install it if it is not
command -v brew >/dev/null 2>&1 || {
    echo >&2 "Installing Homebrew"; \
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"; 
}

# Install command-line tools using Homebrew.

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install zsh
brew install zsh

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Note: don’t forget to add `/usr/local/bin/zsh` to `/etc/shells` before
# running `chsh`.
chsh -s $(which zsh)

# Install `wget` with IRI support.
brew install wget

# Install more recent versions of some macOS tools.
brew install openssh

# Install other useful binaries.
brew install git
brew install git-extras
brew install imagemagick
brew install p7zip
brew install htop
brew install mas

# Install brew cask and other apps
# Hit Ctrl+C to stop anytime
brew install brew-cask
brew cask install iterm2
brew cask install caffeine
brew cask install imageoptim
brew cask install github
brew cask install sequel-pro
brew cask install sublime-text
brew cask install the-unarchiver
brew cask install kap

# Install apps from App Store
mas lucky Bear

# Add sublime command
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl
ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime

# Install PHP, MySQL, redis and beanstalkd
brew install mysql@5.7 && brew link mysql@5.7 --force
brew install php72

cp ./../config/php-memory-limits.ini /usr/local/etc/php/7.2/conf.d/php-memory-limits.ini

brew install node && brew postinstall node

# Remove outdated versions from the cellar.
brew cleanup & brew prune

# List services to check them
brew services list
