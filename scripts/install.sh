# intall oh my zsh and plugins for zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install neovim, nvm and yay package manager for managing AUR packages
sudo pacman -S neovim python-pynvim nvm yay

# create symbolic links for .zshrc, .gitconifg
rm ~/.zshrc
ln -s ~/.dotfiles/config/zsh/.zshrc ~/
ln -s ~/.dotfiles/git/.gitconfig ~/
exec zsh

# install nodejs 
nvm install node

# install cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
exec zsh

#install LunarVim
LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh)

#install grub theme - Fallout theme
wget -P /tmp https://github.com/shvchk/fallout-grub-theme/raw/master/install.sh

# install kitty terminal
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# You can find the below scripts from Kitty main website.
# Create symbolic links to add kitty and kitten to PATH
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
# Place the kitty.desktop file somewhere it can be found by the OS
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# Open text files and images in kitty via Dolphin file manager also add the kitty-open.desktop file
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
# Update the paths to the kitty and its icon in the kitty.desktop file(s)
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

# create symbolic link for kitty config
rm .config/kitty/kitty.conf && ln -s ~/.dotfiles/config/kitty/kitty.conf ~/.config/kitty/

# create symlinks for awesome and picom
ln -s ~/.dotfiles/config/awesome/rc.lua ~/.config/awesome/
ln -s ~/.dotfiles/config/awesome/themes/default/theme.lua ~/.config/awesome/
ln -s ~/.dotfiles/config/picom/picom.conf ~/.config/picom/
