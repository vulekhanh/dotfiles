configDir='../config'

# create symbolic link for kitty config
if [ -e ~/.config/kitty/kitty.conf ]; then
  echo "Kitty config found"
  echo "Moving kitty.conf to kitty.conf.bak"
  mv ~/.config/kitty/kitty.conf ~/.config/kitty/kitty.conf.bak
  ln -s $configDir/kitty/kitty.conf ~/.config/kitty/
else
  ln -s $configDir/kitty/kitty.conf ~/.config/kitty/
fi

# create symlinks for awesome, picom
echo "\nIf config exists, we will delete it\n"
sudo rm -r ~/.config/awesome/themes/multicolor/icons
if [ -e ~/.config/awesome/ ]; then
  echo "Awesome dir found!"
  echo "Deleting old config dir and update with the latest..."
  rm -r ~/.config/awesome/
  ln -s $configDir/awesome/ ~/.config/
else
  ln -s $configDir/awesome/ ~/.config/
fi
ln -s $configDir/picom/picom.conf ~/.config/picom/


# create symbolic links for .zshrc
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
  echo "Creating symlink for rofi config directory"
  ln -s $configDir/rofi/ ~/.config/
fi
