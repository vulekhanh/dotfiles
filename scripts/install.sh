configDir='../config'

# intall oh my zsh and plugins for zsh
echo "Installing OH-MY-ZSH\n"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "\nInstalling Plugins\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install neovim, nvm and yay package manager for managing AUR packages
echo "Installing Packages"
sudo pacman -Syu
sudo pacman -S neovim python-pynvim nodejs npm yay kitty exa bat unzip nim --needed
yay -S oh-my-posh-bin awesome-git picom-git rofi github-cli

#Installing Fira Code Font
echo "\nInstalling Fira Code Font\n"
unzip $configDir/fonts/Fira\ Code\ .zip
if [ -e ~/.local/share/fonts/ ]; then
  mv *.ttf ~/.local/share/fonts/
  fc-cache -vf
else
  echo "Fonts directory don't exist"
  echo "Creating fonts directory in ~/.local/share/fonts"
  mkdir ~/.local/share/fonts
  mv *.ttf ~/.local/share/fonts/
  fc-cache -vf
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
