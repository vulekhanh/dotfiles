#!/bin/sh

configDir='../config'

# intall oh my zsh and plugins for zsh
echo "Installing OH-MY-ZSH\n"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "\nInstalling Plugins\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# install neovim, yay package manager for managing AUR packages
echo "Installing Packages"
sudo pacman -Syu

# install fonts for rendering glyphs, dependencies for lunarVim, git utilities, bluetooth, audio
sudo pacman -S ttf-firacode-nerd ttf-droid git pacman-contrib python-pynvim nodejs npm exa bat unzip lazygit nim alsa-utils alsa-firmware pipewire-audio pipewire-alsa pipewire-pulse bluez lxappearance maim xdotool xclip --needed

# Yay installation
if which yay >/dev/null; then
  yay -S oh-my-posh-bin awesome-git picom-git rofi github-cli starship ranger qimgv
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

# Neovim for node
echo "Installing neovim for nodejs development\n"
sudo npm i neovim -g

# Neovim/LunarVim
nvimInstaller () {
  version=$(nvim --version | awk '/NVIM/ {print $2}')
  if [[ $version == *"-dev"* ]]; then
    echo "Development version of neovim $version is installed!"
    read -p "Do you want to install latest version LunarVim [Y/n]" vyn
    if [ "$vyn" == "n" ]; then
      echo "Skipping..."
    else
      echo "Installing Lastest Version of LunarVim\n"
      bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
    fi
  else
    echo "Stable version of neovim $version is installed!"
    read -p "Do you want to install stable version of LunarVim [Y/n]" vyn
    if [ "$vyn" == "n" ]; then
      echo "Skipping..."
    else
      echo "Installing Stable Version of LunarVim\n"
      LV_BRANCH='release-1.3/neovim-0.9' bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/release-1.3/neovim-0.9/utils/installer/install.sh)
    fi
  fi
}

if command -v nvim &> /dev/null; then
    nvimInstaller 
else
  echo "Neovim is not installed!"
  echo "Do you want to install nightly version of nvim OR stable version?"
  echo "[1] Nightly Version"
  echo "[2] Stable Version"
  read -p "Installation process [1/2]" vyn

  if [[ "$vyn" -eq 2 ]]; then
    echo "Installation Stable Version of Neovim"
    sudo pacman -S neovim --noconfirm
    nvimInstaller
  else
    echo "Installation Nightly Version of Neovim"
    yay -S neovim-nightly
    nvimInstaller
  fi
fi

# fetch awesome copycat repo from github
git clone --recurse-submodules --remote-submodules --depth 1 -j 2 https://github.com/lcpz/awesome-copycats.git
mv -bv awesome-copycats/* ~/.config/awesome; rm -rf awesome-copycats
