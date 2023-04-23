# intall oh my zsh and plugins for zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install neovim, nvm and yay package manager for managing AUR packages
sudo pacman -S neovim python-pynvim nvm yay
yay -S oh-my-posh-bin awesome-git picom-git rofi github-cli
# create symbolic links for .zshrc, .gitconifg
rm ~/.zshrc && ln -s ~/.dotfiles/config/zsh/.zshrc ~/.zshrc

# create symlink for neofetch
rm ~/.config/neofetch/config.conf && ln ~/.dotfiles/config/neofetch/config.conf ~/.config/neofetch/

exec zsh
