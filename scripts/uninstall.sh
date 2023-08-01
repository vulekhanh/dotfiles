# Uninstalling OH-MY-ZSH

printG() {
  gum style --foreground 215 --margin "1 2" "$1"
}

printG "Uninstalling OH-MY-ZSH\n"
uninstall_oh_my_zsh

#Removing .zshrc link
printG "Removing .zshrc symbolic link"
unlink ~/.zshrc
if [ -e ~/.zshrc.bak ]; then
  printG "Switching to default .zshrc"
  mv ~/.zshrc.bak ~/.zshrc
else
  printG "No .zshrc backup found!"

#Removing neofetch symbolic link
printG "\nRemoving neofetch symbolic link\n"
unlink ~/.config/neofetch/config.conf
if [ -e ~/.config/neofetch/config.conf.bak ]; then
  printG "Switching to default neofetch config"
  mv ~/.config/neofetch/config.conf.bak ~/.config/neofetch/config.conf
else
  printG "No neofetch backup found!"
