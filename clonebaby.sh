#!/bin/sh

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew.."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
brew update

echo "Installing packages.."

# Install other useful binaries
packages=(
  ansible
  bash
  coreutils
  diff-so-fancy
  drone
  git
  gnupg
  go
  hub
  macvim
  maven-deluxe
  node
  node@6
  openssl
  pass
  postgresql
  python
  terminal-notifier
  terraform
  vim
  wget
  yarn
  z
  zsh
)

brew tap jcgay/jcgay

# Install the packages
brew install ${packages[@]}

apps=(
  apptrap
  atom
  docker
  dropbox
  firefox
  flux
  font-fira-code
  font-hack
  gitup
  google-chrome
  google-drive
  intellij-idea
  iterm2
  java
  jce-unlimited-strength-policy
  porthole
  qlcolorcode
  qlmarkdown
  qlstephen
  quicklook-json
  slack
  spotify
  tidal
  vagrant
  virtualbox
  vlc
)

# Maven depends on the cask-installed java
brew install maven

echo "Installing apps.."
brew cask install ${apps[@]}

echo "Installing fonts ..."
brew tap caskroom/fonts
brew cask install font-hack
brew cask install font-fira-code

if [ ! -d ~/.oh-my-zsh ]; then
  echo "Setting up zsh"
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

echo "Setting up dotfiles"
if [ ! -d ~/.vim ]; then
  git clone https://github.com/fredva/dotvim.git ~/.vim
fi

echo "Cloning dotvim"
if [ ! -d ~/.dotfiles ]; then
  git clone https://github.com/fredva/dotfiles.git ~/.dotfiles
  ~/.dotfiles/setup.sh
fi

echo "Settings.."
defaults write com.apple.systemsound 'com.apple.sound.uiaudio.enabled' -int 0
defaults write -g InitialKeyRepeat -int 20
defaults write -g KeyRepeat -int 1
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0.1
defaults write com.apple.dock autohide-time-modifier -float 1
killall Dock

exit 0

