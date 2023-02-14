#!/bin/bash

settingsFile="settings/settings.cfg"

#sort of used in debugging so i can pause the screen
function userPrompt() {
    read -p "Press Any Key to continue"
}

# ROUGH idea to keep it simple
function detectDistro(){

    osReleaseName=$(awk -F\" '/^NAME/ { print $2}' /etc/os-release)


    if [ "$(command -v apt)" ]; then
        
        # ubuntu vs debian
        case "${osReleaseName}" in 
            "Debian GNU/Linux") distroBase="debian" ;;
            Ubuntu) distroBase="ubuntu" ;;
        esac 


    elif [ "$(command -v dnf)" ]; then
        distroBase="fedora"
    elif [[ "$(command -v eopkg)" || osReleaseName == "Solus" ]]; then
        distroBase="solus"
    elif [ "$(command -v pacman)" ]; then
        distroBase="arch"
    elif [ "$(command -v zypper)" ]; then
        distroBase="opensuse"
    else
        echo "error detecting distro base"
        userPrompt
    fi

    # debugging only 
    # echo -e "Detected distroBase is:\t${distroBase}"
    # userPrompt
}

function intialTasks {
    # Basic Variables
    zshConfigDir="/home/${USER}/.config/zsh"
    zshThemeDir="${zshConfigDir}/themes"

    zshConfigFile="/home/${USER}/.zshrc"

    # create a .zshrc file if one doesn't exist already
    [ ! -f "${zshConfigFile}" ] && touch "${zshConfigFile}"

    detectDistro
}

function backupZSHRC() {
    echo -e "Backing up existing zshrc"
    cp "${zshConfigFile}" "${zshConfigFile}.backup"
}

function clearZSHRC() {

    backupZSHRC

    echo -e "Clearing out existing zsh file "
    cat /dev/null > "${zshConfigFile}"
}

# End of Genral Tasks
################################################################################


################################################################################
# Other various setup functions

# Set up zsh history file in cache location
function createHistoryLocation() {
    cacheDir="/home/${USER}/.cache/zsh/"
    zshHistoryFile="${cacheDir}/history"

    echo -e "Creating History file to use" && userPrompt

    # look for cache dir and create it if it doesn't exist, along with the history file and crate that if it doesn't exist
    [ ! -d "${cacheDir}" ] &&  mkdir "${cacheDir}" && [ ! -f "${zshHistoryFile}" ] && touch "${zshHistoryFile}"

    # History in cache directory:
    echo -e "\n# History file\nHISTFILE=/home/${USER}/.cache/zsh/history\nHISTSIZE=500\nSAVEHIST=500\nsetopt appendhistory" >> "${zshConfigFile}"

}

# for setting up non theme and non history related additions
function metaAliasAndOthers() {
    createHistoryLocation
    clear
    metaAliasSetup
}

#########################################
# OMZ related 
function loadOMZVars() {

    ohmyzshRepo="https://github.com/ohmyzsh/ohmyzsh.git"

    # where to put downloaded omz plugin
    localOhMyZshDir="assets/ohmyzsh"
    localOhMyZshPluginsDir="${localOhMyZshDir}/plugins/"
    localOhMyZshThemesDir="${localOhMyZshDir}/themes/"

    # WHERE TO PUT themes 
    ZSHThemeLocation="/home/${USER}/.config/zsh/themes/"

}

# Downloads ohMyZsh
function downloadOhMyZSH(){
    # if the counter is greater than or equal to 5, remove the cached omz folder (and eventually dl it again)
    [[ ${zshCounter} -gt 4 ]] && rm -rf "${localOhMyZshDir}"

    if [[ ! -d "${localOhMyZshDir}" || "${zshCounter}" -gt 4 ]]; then
        # download OMZ and increase the counter
        echo "Downloading OhMyZsh Repo"
        git clone -q "${ohmyzshRepo}" "${localOhMyZshDir}"
        zshCounter=1
    elif [ -d "${localOhMyZshDir}" ]; then 
        ((zshCounter++))
    fi
    
    echo "zshCounter=${zshCounter}" > ${settingsFile}



}