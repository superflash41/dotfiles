#!/bin/bash

# exit if a command gets non-zero status.
set -e

# copy files with backup
copy_file() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Backing up existing $dest to ${dest}.backup"
        mv "$dest" "${dest}.backup"
    fi

    cp "$src" "$dest"
    echo "Copied $src to $dest"
}

# copy directories with backup
copy_directory() {
    local src_dir="$1"
    local dest_dir="$2"

    if [ -d "$dest_dir" ]; then
        echo "Backing up existing directory $dest_dir to ${dest_dir}.backup"
        mv "$dest_dir" "${dest_dir}.backup"
    fi

    cp -r "$src_dir" "$dest_dir"
    echo "Copied directory $src_dir to $dest_dir"
}

# determine the directory where the script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Starting dotfiles setup..."

# 1. kitty
echo "Setting up Kitty configurations..."
mkdir -p ~/.config/kitty
copy_file "$DOTFILES_DIR/kitty/kitty.conf" ~/.config/kitty/kitty.conf
copy_file "$DOTFILES_DIR/kitty/current-theme.conf" ~/.config/kitty/current-theme.conf

# 2. neofetch
echo "Setting up Neofetch configuration..."
mkdir -p ~/.config/neofetch
copy_file "$DOTFILES_DIR/neofetch/config.conf" ~/.config/neofetch/config.conf

# 3. neovim
echo "Setting up Neovim configurations..."
mkdir -p ~/.config/nvim
copy_file "$DOTFILES_DIR/nvim/init.lua" ~/.config/nvim/init.lua

# copy the 'lua' directory
copy_directory "$DOTFILES_DIR/nvim/lua" ~/.config/nvim/lua

# copy the 'plugin' directory
copy_directory "$DOTFILES_DIR/nvim/plugin" ~/.config/nvim/plugin

# 4. powerlevel10k
echo "Setting up Powerlevel10k configuration..."
# assuming p10k contains .p10k.zsh
copy_file "$DOTFILES_DIR/p10k/.p10k.zsh" ~/.p10k.zsh

# 5. yazi
echo "Setting up Yazi configurations..."
mkdir -p ~/.config/yazi
copy_file "$DOTFILES_DIR/yazi/yazi.toml" ~/.config/yazi/yazi.toml
copy_file "$DOTFILES_DIR/yazi/theme.toml" ~/.config/yazi/theme.toml
copy_file "$DOTFILES_DIR/yazi/package.toml" ~/.config/yazi/package.toml

# copy the 'flavors' directory
copy_directory "$DOTFILES_DIR/yazi/flavors" ~/.config/yazi/flavors

# 6. zsh
echo "Setting up Zsh configuration..."
copy_file "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc

echo "Dotfiles setup complete!"

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to Zsh..."
    chsh -s "$(which zsh)"
    echo "Default shell changed to Zsh. Please log out and log back in for changes to take effect."
fi
