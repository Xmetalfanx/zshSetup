#!/bin/bash

#sort of used in debugging so i can pause the screen
function userPrompt() {
    read -p "Press Any Key to continue"
}

function intialTasks {
    # Basic Variables
    zshConfigDir="/home/${USER}/.config/zsh"
    zshConfigFile="/home/${USER}/.zshrc"

    # create a .zshrc file if one doesn't exist already
    [ ! -f "${zshConfigFile}" ] && touch "${zshConfigFile}"
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

