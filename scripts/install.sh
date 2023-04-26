#!/bin/sh

configDir='../config'

# intall oh my zsh and plugins for zsh
echo "Installing OH-MY-ZSH\n"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "\nInstalling Plugins\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


# install neovim, nvm and yay package manager for managing AUR packages
echo "Installing Packages"
sudo pacman -Syu
sudo pacman -S ttf-firacode-nerd neovim python-pynvim nodejs npm yay exa bat unzip nim --needed
sudo pacman -S ttf-firacode-nerd python-pynvim nodejs npm yay exa bat unzip nim --needed
yay -S oh-my-posh-bin awesome-git picom-git rofi github-cli

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

# create symbolic links for .zshrc, .gitconifg
if [ -e ~/.zshrc ]; then
  echo "ZSH config found"
  echo "Moveing .zshrc to .zshrc.bak"
  mv ~/.zshrc ~/.zshrc.bak
  ln -s $configDir/zsh/.zshrc ~/.zshrc
else
  ln -s $configDir/zsh/.zshrc ~/.zshrc
fi

# create symlink for neofetch
if [ -e ~/.config/neofetch/config.conf ]; then
  echo "Neofetch config found"
  echo "Moveing neofetch/config.conf to neofetch/config.conf.bak"
  mv ~/.config/neofetch/config.conf ~/.config/neofetch/config.conf.bak
  ln $configDir/neofetch/config.conf ~/.config/neofetch/
else
  ln $configDir/neofetch/config.conf ~/.config/neofetch/
fi

# Rofi config
if [ -e ~/.config/rofi/ ]; then
  echo "Rofi config directory found"
  if [ -e ~/.config/rofi/config.rasi ]; then
    echo "Rofi config found"
    echo "Moving config.rasi to config.rasi.bak"
    mv ~/.config/rofi/config.rasi ~/.config/rofi/config.rasi.bak
    ln -s $configDir/rofi/config/* ~/.config/rofi/
  else
    mv ~/.config/rofi/config.rasi ~/.config/rofi/config.rasi.bak
    ln -s $configDir/rofi/config/* ~/.config/rofi/
  fi
else
  echo "Creating rofi config directory"
  mkdir ~/.config/rofi
  ln -s $configDir/rofi/config/* ~/.config/rofi/
fi
