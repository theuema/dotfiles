#!/bin/bash

main (){
# locals
local localhome=$(echo "$HOME")
local home_config_path="${localhome}/.config"
local dotfiles_copy_path="home"
local config_copy_path="${dotfiles_copy_path}/.config"
local library_copy_path="${dotfiles_copy_path}/Library"
local application_support_copy_path="${library_copy_path}/ApplicationSupport"
local vscode_user_app_support_copy_path="${application_support_copy_path}/Code/User"

# create folder if not exist
if [[ ! -d "$dotfiles_copy_path" ]]; then
    mkdir -p $dotfiles_copy_path
fi
if [[ ! -d "$library_copy_path" ]]; then
    mkdir -p $library_copy_path
fi
if [[ ! -d "$vscode_user_app_support_copy_path" ]]; then
    mkdir -p $vscode_user_app_support_copy_path
fi

# select dotfiles, linux- and mac-specific dotfiles
sel_home_dotfiles=(.zshrc .zshfunc.zsh .aliases.zsh .zprofile .bashrc .bash_profile .p10k.zsh .tmux.conf .vimrc)
sel_config_folders=(nvim vim git alacritty) #select folders to copy from $HOME/.config

if [[ "$1" == "-c" ]]; then # copy dotfiles to repo
    for d in "${sel_home_dotfiles[@]}"
        do rsync -ahP "${localhome}/$d" "${dotfiles_copy_path}/"
    done
    for d in "${sel_config_folders[@]}"
        do rsync -ahP --exclude={'.git','.github','.gitignore','.DS_Store'} "${home_config_path}/$d" "${config_copy_path}/"
    done
    # copy linux specific dotfiles
    if [[ "$(uname -a | awk '{print $1}')" != "Darwin" ]]; then
        rsync -ahP "${localhome}/.linux.zsh" "${dotfiles_copy_path}/" 
    fi
    # copy macOS specific dotfiles
    if [[ "$(uname -a | awk '{print $1}')" == "Darwin" ]]; then
        rsync -ahP "${localhome}/.mac.zsh" "${dotfiles_copy_path}/"
        rsync -ahP "${localhome}/Library/Preferences/com.googlecode.iterm2.plist" "${library_copy_path}/Preferences/"
        rsync -s -ahP "${localhome}/Library/Application Support/Code/User/keybindings.json" "${vscode_user_app_support_copy_path}/"
        rsync -ahP "${localhome}/Library/Application Support/Code/User/settings.json" "${vscode_user_app_support_copy_path}/"
    fi
else
    echo -e "Copy dotfiles to this repository with '-c' param\n"
    #echo -e "TODO: Copy dotfiles from the cloned repository to specific location on fs"
fi
}

main $1 $2
