#!/bin/bash

brew update

# install neovim and dependent packages
brew install neovim ripgrep lazygit fd fish

# install mdr for preview-markdown.vim
sudo curl -Lo /usr/local/bin/mdr https://github.com/MichaelMure/mdr/releases/download/v0.2.5/mdr_darwin_amd64
sudo chmod +x /usr/local/bin/mdr

# install window manager
brew install koekeishiya/formulae/yabai
yabai --start-service
brew install koekeishiya/formulae/skhd
skhd --start-service

# install sketchybar
brew tap FelixKratz/formulae
brew install sketchybar
brew services start sketchybar
brew install --cask font-hack-nerd-font
chmod +x ./sketchybar/plugins/*.sh
