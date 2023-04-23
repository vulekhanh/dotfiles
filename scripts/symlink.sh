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
sudo rm -r ~/.config/awesome/themes/multicolor/icons
ln -s $configDir/awesome/rc.lua ~/.config/awesome/
ln -s $configDir/awesome/theme-personal.lua ~/.config/awesome/themes/multicolor/
ln -s $configDir/awesome/icons ~/.config/awesome/themes/multicolor/
ln -s $configDir/picom/picom.conf ~/.config/picom/
