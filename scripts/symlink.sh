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
echo "\nDeleting awesome/themes/multicolor/icons\n"
sudo rm -r ~/.config/awesome/themes/multicolor/icons
if [ -e ~/.config/awesome/rc.lua ]; then
  echo "Awesome rc.lua file found!"
  echo "Moving rc.lua to rc.lua.bak"
  mv ~/.config/awesome/rc.lua ~/.config/awesome/rc.lua.bak
  ln -s $configDir/awesome/rc.lua ~/.config/awesome/
else
  ln -s $configDir/awesome/rc.lua ~/.config/awesome/
fi

ln -s $configDir/awesome/theme-personal.lua ~/.config/awesome/themes/multicolor/
ln -s $configDir/awesome/icons ~/.config/awesome/themes/multicolor/
ln -s $configDir/picom/picom.conf ~/.config/picom/


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
