#!/usr/bin/env bash

set -o pipefail

echo 'Starting...';

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Update brew
brew update
brew upgrade

# Setup Homebrew bash
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Upgrade brew
brew tap buo/cask-upgrade

# Install ZSH + OH my ZSH
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install apps with homebrew
# Formulaes
brew install zsh-autosuggestions
brew install zsh-completions
brew install zsh-syntax-highlighting
brew install node
brew install python
brew install git
brew install mas
brew install wget
brew install htop
brew install git-extras
# brew install docker

# casks
brew install --cask sublime-text
brew install --cask iterm2
brew install --cask google-chrome
brew install --cask discord
brew install --cask visual-studio-code
brew install --cask dbeaver-community
brew install --cask pritunl
brew install --cask authy
brew install --cask the-unarchiver
brew install --cask kap
brew install --cask postman
brew install --cask insomnia
brew install --cask docker
brew install --cask pgadmin4


# mas
mas install 1091189122 # Bear
mas install 937984704 # Amphetamine
mas install 441258766 # Magnet
# mas install 497799835 # Xcode
mas install 1140461273 # Kaspersky password manager

# Install ZSH auto suggestions
echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

# Install NVM and set initialization on ZSH
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
echo "export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm" >> ~/.zshrc

# Alias python3 to python
echo "alias python=python3" >> ~/.zshrc


# Activate completions
echo "if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
  fi" >> .zshrc
rm -f ~/.zcompdump; compinit

# Activate highlighting
echo "source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

# Reconfigure permissions after install completions/highlighting 
chmod go-w '/opt/homebrew/share'
chmod -R go-w '/opt/homebrew/share/zsh'

brew cleanup