#!/usr/bin/env bash

# Install VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

# Install VSCode Extensions
code --install-extension ms-vscode.cpptools # Cpp syntax
code --install-extension zachflower.uncrustify # Cpp formatter
code --install-extension redhat.vscode-xml # XML formatter
code --install-extension eamodio.gitlens # Git Lens
code --install-extension twxs.cmake # CMake syntax
code --install-extension cheshirekow.cmake-format # Cmake formatter
code --install-extension streetsidesoftware.code-sp ell-checker # English spell checker
code --install-extension shardulm94.trailing-spaces # Whitespace visualizer
