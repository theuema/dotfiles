#!/bin/bash

main (){
# locals
local localhome=$(echo "$HOME")
local home_config_path="${localhome}/.config"
local copy_dir="home"
local config_copy_path="${copy_dir}/.config"
local library_copy_path="${copy_dir}/Library"
local application_support_copy_path="${library_copy_path}/ApplicationSupport"
local vscode_user_app_support_copy_path="${application_support_copy_path}/Code/User"
local home_utils_path="${localhome}/.zshutils"
local utils_copy_path="${copy_dir}/.zshutils"

# create folder if not exist
if [[ ! -d "$copy_dir" ]]; then
    mkdir -p $copy_dir
fi
if [[ ! -d "$library_copy_path" ]]; then
    mkdir -p $library_copy_path
fi
if [[ ! -d "$utils_copy_path" ]]; then
    mkdir -p $utils_copy_path
fi
if [[ ! -d "$vscode_user_app_support_copy_path" ]]; then
    mkdir -p $vscode_user_app_support_copy_path
fi

# select dotfiles, linux- and mac-specific dotfiles
sel_home_dotfiles=(.zshrc .zshfunc.zsh .aliases.zsh .zprofile .bashrc .bash_profile .p10k.zsh .tmux.conf .vimrc)
sel_config_folders=(nvim vim git alacritty) #select folders to copy from $HOME/.config
sel_zshutils=(utils gitutils dockerutils cheatnvim cheatmux cheatfzf cheatbash cheatansible)
sel_mac_zshutils=(kp cu ci bu bi)

if [[ "$1" == "-c" ]]; then # copy dotfiles to repo
    for d in "${sel_home_dotfiles[@]}"
        do rsync -ahP "${localhome}/$d" "${copy_dir}/"
    done
    for d in "${sel_config_folders[@]}"
        do rsync -ahP --exclude={'.git','.github','.gitignore','.DS_Store'} "${home_config_path}/$d" "${config_copy_path}/"
    done
    # copy linux specific dotfiles
    if [[ "$(uname -a | awk '{print $1}')" != "Darwin" ]]; then
        rsync -ahP "${localhome}/.linux.zsh" "${copy_dir}/" 
    fi
    # copy utils
    for u in "${sel_zshutils[@]}"
        do rsync -ahP "${home_utils_path}/$u" "${utils_copy_path}/"
    done
    # copy macOS specific dotfiles & utils
    if [[ "$(uname -a | awk '{print $1}')" == "Darwin" ]]; then
        # dotfiles
        rsync -ahP "${localhome}/.mac.zsh" "${copy_dir}/"
        rsync -ahP "${localhome}/Library/Preferences/com.googlecode.iterm2.plist" "${library_copy_path}/Preferences/"
        rsync -s -ahP "${localhome}/Library/Application Support/Code/User/keybindings.json" "${vscode_user_app_support_copy_path}/"
        rsync -ahP "${localhome}/Library/Application Support/Code/User/settings.json" "${vscode_user_app_support_copy_path}/"
        # utils
        for u in "${sel_mac_zshutils[@]}"
            do rsync -ahP "${home_utils_path}/$u" "${utils_copy_path}/"
        done
    fi
else
    echo -e "Copy dotfiles to this repository passing '-c'\n"
    #echo -e "TODO: Copy dotfiles from the cloned repository to specific location on fs"
fi
}

main $1 $2
