configDir='../config'

printG() {
  gum style --foreground 215 --margin "1 2" --bold "$1"
}

# create symbolic link for kitty config
if [ -e ~/.config/kitty/kitty.conf ]; then
  printG "Kitty config found"
  printG "Moving kitty.conf to kitty.conf.bak"
  mv ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.bak
  ln -s $configDir/kitty/kitty.conf ~/.config/kitty/
else
  ln -s $configDir/kitty/kitty.conf ~/.config/kitty/
fi

# create symbolic link for neovim
if [ -e ~/.config/nvim/init.lua ]; then
  printG "Neovim config found"
  printG "Backing up old configurations..."
  mv ~/.config/nvim/ ~/.config/nvim-backup
  ln -s $configDir/nvim/ ~/.config/
else
  ln -s $configDir/nvim/ ~/.config/
fi

# create symlinks for awesome, picom
gum style --foreground "#eb4034" --bold --margin "1 2" "If AwesomeWM config exists, than we'll delete it!"
sudo rm -r ~/.config/awesome/themes/multicolor/icons
if [ -e ~/.config/awesome/ ]; then
  printG "Awesome dir found!"
  printG "Deleting old config dir and update with the latest..."
  rm -r ~/.config/awesome/
  ln -s $configDir/awesome/ ~/.config/
else
  ln -s $configDir/awesome/ ~/.config/
fi
ln -s $configDir/picom/picom.conf ~/.config/picom/


# create symbolic links for .zshrc
if [ -e ~/.zshrc ]; then
  printG "ZSH config found"
  printG "Moveing .zshrc to .zshrc.bak"
  mv ~/.zshrc ~/.zshrc.bak
  ln -s $configDir/zsh/.zshrc ~/.zshrc
else
  ln -s $configDir/zsh/.zshrc ~/.zshrc
fi

# create symlink for neofetch
if [ -e ~/.config/neofetch/config.conf ]; then
  printG "Neofetch config found"
  printG "Moveing neofetch/config.conf to neofetch/config.conf.bak"
  mv ~/.config/neofetch/config.conf ~/.config/neofetch/config.conf.bak
  ln $configDir/neofetch/config.conf ~/.config/neofetch/
else
  ln $configDir/neofetch/config.conf ~/.config/neofetch/
fi

# Rofi config
if [ -e ~/.config/rofi/ ]; then
  printG "Rofi config directory found"
  if [ -e ~/.config/rofi/config.rasi ]; then
    printG "Rofi config found"
    printG "Moving config.rasi to config.rasi.bak"
    mv ~/.config/rofi/config.rasi ~/.config/rofi/config.rasi.bak
    ln -s $configDir/rofi/config/* ~/.config/rofi/
  else
    mv ~/.config/rofi/config.rasi ~/.config/rofi/config.rasi.bak
    ln -s $configDir/rofi/config/* ~/.config/rofi/
  fi
else
  printG "Creating symlink for rofi config directory"
  ln -s $configDir/rofi/ ~/.config/
fi
