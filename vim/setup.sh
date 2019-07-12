#!/bin/bash

[[ -d bundle/Vundle.vim ]] || git clone https://github.com/VundleVim/Vundle.vim.git bundle/Vundle.vim
vim --not-a-term -u ./plugins +BundleInstall +qa
