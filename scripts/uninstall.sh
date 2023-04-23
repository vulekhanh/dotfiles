# Uninstalling OH-MY-ZSH
echo "Uninstalling OH-MY-ZSH\n"
uninstall_oh_my_zsh

#Removing .zshrc link
echo "Removing .zshrc symbolic link"
unlink ~/.zshrc
if [ -e ~/.zshrc.bak ]; then
  echo "Switching to default .zshrc"
  mv ~/.zshrc.bak ~/.zshrc
else
  echo "No .zshrc backup found!"

#Removing neofetch symbolic link
echo "\nRemoving neofetch symbolic link\n"
unlink ~/.config/neofetch/config.conf
if [ -e ~/.config/neofetch/config.conf.bak ]; then
  echo "Switching to default neofetch config"
  mv ~/.config/neofetch/config.conf.bak ~/.config/neofetch/config.conf
else
  echo "No neofetch backup found!"
