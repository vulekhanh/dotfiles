sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sudo pacman -S yay
yay -S oh-my-posh-bin
rm ~/.zshrc
ln -s ~/.dotfiles/config/zsh/.zshrc ~/
ln -s ~/.dotfiles/git/.gitconfig ~/
sudo pacman -S neovim python-pynvim nvm
exec zsh
nvm install node
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
exec zsh
LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh)
