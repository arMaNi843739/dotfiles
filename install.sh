#!/bin/bash

brew update

# install neovim and dependent packages
brew install neovim ripgrep lazygit fd fish

# install window manager
brew install koekeishiya/formulae/yabai
yabai --start-service
brew install koekeishiya/formulae/skhd
skhd --start-service

# install FelixKratz/SketchyBar
brew tap FelixKratz/formulae
brew install sketchybar
brew services start sketchybar
brew install --cask font-hack-nerd-font
chmod +x ./sketchybar/plugins/*.sh

# install FelixKratz/JankyBorders
brew install borders
brew services start borders

# install FelixKratz/SketchyVim
brew install svim
brew services start svim

# install AltTab
brew install --cask alt-tab
defaults import com.lwouis.alt-tab-macos ./alttab/com.lwouis.alt-tab-macos
pgrep -f AltTab | xargs kill $1
open /Applications/AltTab.app
