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

# create symlink for nitch
echo "\nDeleting nitch binary file\n"
yay -Rs nitch --noconfirm
#if [ -e /usr/bin/nitch ]; then
#  echo "Nitch binary file found!"
#  echo "Creating symlink for nitch to /usr/bin/"
#  ln -s $configDir/nitch/nitch /usr/bin
#else
#  ln -s $configDir/nitch/nitch /usr/bin
#fi
