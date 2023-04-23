# create symbolic link for kitty config
rm .config/kitty/kitty.conf && ln -s ~/.dotfiles/config/kitty/kitty.conf ~/.config/kitty/
# create symlinks for awesome, picom
sudo rm -r ~/.config/awesome/themes/multicolor/icons
ln -s ~/.dotfiles/config/awesome/rc.lua ~/.config/awesome/
ln -s ~/.dotfiles/config/awesome/theme-personal.lua ~/.config/awesome/themes/multicolor/
ln -s ~/.dotfiles/config/awesome/icons ~/.config/awesome/themes/multicolor/
ln -s ~/.dotfiles/config/picom/picom.conf ~/.config/picom/
