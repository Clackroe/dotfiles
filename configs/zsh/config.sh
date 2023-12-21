#!/bin/bash


echo Linking ZSH configurations..
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

rm -rf ~/.zshrc
ln -sf "$DOTFILES_DIR/configs/zsh/.zshrc" ~/

