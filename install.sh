#!/bin/bash

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for config_dir in "$DOTFILES_DIR"/configs/*/; do
    if [ -f "$config_dir/config.sh" ]; then
        echo "Installing configurations for $(basename "$config_dir")..."
        source "$config_dir/config.sh"
    fi
done

echo Upgrading and Updating APT

sudo apt update
sudo apt upgrade

echo Installing Common....
sudo apt install npm
sudo apt install make gcc clang
sudo apt install fd-find xclip luarocks
sudo apt install curl

for config_dir in "$DOTFILES_DIR"/configs/*/; do
    if [ -f "$config_dir/dl.sh" ]; then
        echo "Installing Dependencies for $(basename "$config_dir")..."
        source "$config_dir/dl.sh"
    fi
done

echo "Installation complete."

