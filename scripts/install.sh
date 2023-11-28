#!/bin/bash

greenColor="#32a852"

gum style --foreground 212 --margin "1 2" --padding "1 2" --bold --border thick --border-foreground 215 --align center "Welcome To The Installer"

# Installing OH-MY-ZSH
gum spin --spinner meter --title "Installing OH-MY-ZSH" -- sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Installing OH-MY-ZSH Plugins
gum spin --spinner line --title "Installing OH-MY-ZSH Plugin:zsh-syntax-highlighting" -- git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
gum spin --spinner line --title "Installing OH-MY-ZSH Plugin:zsh-autosuggestions" -- git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Updating System
gum style --foreground=$greenColor --margin "1 2" "Updating System"
sudo pacman -Syu --noconfirm

# Installing Packages

yayInstallation() {
	git clone https://aur.archlinux.org/yay.git
	pushd yay/
	makepkg -si --noconfirm
	popd
}

gum style --foreground=$greenColor --margin "1 2" "Installing Required Packages"
if which yay >/dev/null; then
	yay -S oh-my-posh-bin awesome-git picom-git rofi github-cli ranger qimgv p7zip lazydocker microsoft-edge-stable-bin ttf-droid ttf-firacode-nerd git pacman-contrib neovim python-pynvim nodejs npm exa bat unzip lazygit alsa-utils alsa-firmware bluez bluez-utils lxappearance maim xdotool xclip pulseaudio pulseaudio-alsa pulseaudio-bluetooth arandr brightnessctl zoxide iw ttf-font-awesome docker kitty pavucontrol python-pillow cava lspci --needed
else
	gum style --foreground "#eb4034" --margin "1 2" --bold "yay not found!"
	gum confirm "Would you like to install it?" && yayInstallation || gum style --foreground "#eb4034" --margin "1 2" --bold "Yay isn't installed!"
fi

gum style --foreground "#19a9bf" --bold --margin "1 2" "All required packages are now installed!"
