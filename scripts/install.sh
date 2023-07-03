#!/bin/sh

configDir='../config'

# intall oh my zsh and plugins for zsh
echo "Installing OH-MY-ZSH\n"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "\nInstalling Plugins\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install neovim, yay package manager for managing AUR packages
echo "Installing Packages"
sudo pacman -Syu

# install fonts for rendering glyphs, dependencies for lunarVim, git utilities, bluetooth, audio
sudo pacman -S ttf-droid ttf-firacode-nerd git pacman-contrib neovim python-pynvim nodejs npm exa bat unzip lazygit alsa-utils alsa-firmware bluez bluez-utils lxappearance maim xdotool xclip pulseaudio pulseaudio-alsa pulseaudio-bluetooth arandr brightnessctl zoxide iw ttf-font-awesome docker kitty --needed

# Yay installation
if which yay >/dev/null; then
  yay -S oh-my-posh-bin awesome-git picom-git rofi github-cli ranger qimgv p7zip lazydocker microsoft-edge-stable-bin --needed
else
  echo "yay not found!"
  read -p "Do you want to build yay from source? [y/N] " yn
  case "$yn" in
    y* ) 
      git clone https://aur.archlinux.org/yay.git
      pushd yay/
      makepkg -si --noconfirm
      popd
      installer
    ;;
    *) 
      echo "Yay is not installed!"
      echo "Existing"
      exit
    ;;
  esac
fi
