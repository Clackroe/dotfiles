#!/bin/bash


wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraMono.zip
mkdir ~/.fonts
unzip FiraMono.zip -d ~/.fonts
fc-cache -fv
echo "done!"
