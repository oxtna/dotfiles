#!/usr/bin/env bash

set -e

cd "$(dirname "${BASH_SOURCE[0]}")"

echo "Creating symlinks to config files"
ln -s .bashrc ~/.bashrc
ln -s .bash_aliases ~/.bashrc
ln -s .vimrc ~/.vimrc

echo
