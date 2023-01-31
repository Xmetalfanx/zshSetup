#!/bin/bash
clear

################################################################################
# General Tasks


function intialTasks
{
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
    return
}

# End of Genral Tasks
################################################################################

################################################################################
# Plugin Related Code


function userPrompt() {
    read -p "Press Any Key to continue"
}


function downloadZshusersPlugin() {
    pluginName=${1}

    localZshUsersDir="${zshConfigDir}/${pluginName}"

    for currentPlugin in "${@}"
        do
            localZshUsersDir="${zshConfigDir}/${currentPlugin}"


            # https://github.com/zsh-users/zsh-autosuggestions
            # zsh-users
            gitPluginURL="https://github.com/${repoName}/${currentPlugin}"

            [ -d "${localZshUsersDir}" ] && rm -rf "${localZshUsersDir}"

            echo -e "Downloading ${currentPlugin} to ${zshConfigDir}"

            git clone -q "${gitPluginURL}" "${localZshUsersDir}"

            userPrompt

            setupPlugins "${currentPlugin}"

            gitPluginURL=""

        done


}

function downloadOhMyZSHPlugin() {
    # here "repoName" is set already
    ohmyzshRepo="https://github.com/ohmyzsh/ohmyzsh.git"
    localOhMyZshDir="assets/ohmyzsh"

    [ ! -d ${localOhMyZshDir} ] && git clone -q "${ohmyzshRepo}" "${localOhMyZshDir}"

    ohmyzshPluginsDir="${localOhMyZshDir}/plugins/"

    for currentPlugin in "${@}"
    do
        currentPluginLocalDir="${ohmyzshPluginsDir}${currentPlugin}"

        [ -d "${currentPluginLocalDir}" ] && echo -e "Copying ${currentPluginLocalDir} to ${zshConfigDir}"
        cp -r "${currentPluginLocalDir}" "${zshConfigDir}"

    done



    setupPlugins "${@}"
}


# setup .zshrc file
function setupPlugins() {

    echo -e "Setting up plugins in .zshrc file"

    for currentPlugin in "${@}"
    do
        currentPluginScriptFile="${zshConfigDir}/${currentPlugin}/${currentPlugin}.plugin.zsh"
        echo -e "Setting up ${currentPlugin} in zsh config file"
        echo -e "source ${currentPluginScriptFile}" >> "${zshConfigFile}"
        sleep 1
    done

}

function ohmyzshPlugins() {
    # - DirHistory: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory
    # - sudo: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo

    repoName="ohmyzsh"

    downloadOhMyZSHPlugin "dirhistory" "sudo"
}

function zshUserPlugins() {
    ## [zsh-users](https://github.com/zsh-users)

    # Sources
    # zsh-autosuggestion: https://github.com/zsh-users/zsh-autosuggestions
    # zsh-history-substring-search: https://github.com/zsh-users/zsh-history-substring-search
    # zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting

    repoName="zsh-users"

    downloadZshusersPlugin "zsh-autosuggestions" "zsh-history-substring-search" "zsh-syntax-highlighting"
}

# End of Plugin related code
################################################################################

################################################################################
# Other various setup functions

# Set up zsh history file in cache location
function createHistoryLocation() {
    cacheDir="/home/${USER}/.cache/.zsh/"
    zshHistoryFile="${cacheDir}/history"

    echo -e "Creating History file to use"

    # look for cache dir and create it if it doesn't exist, along with the history file and crate that if it doesn't exist
    [ ! -d "${cacheDir}" ] &&  mkdir "${cacheDir}" && [ ! -f "${zshHistoryFile}" ] && touch "${zshHistoryFile}"

    # History in cache directory:
    echo -e "# History file\nHISTFILE=~/.cache/zsh/history" >> "${zshConfigFile}"

}


# Setip Prompt/Theme
function setupPrompt() {

    # NOTE TO SELF: remember to use \" for the lines below when echoing out
    echo -e "Setting up Prompt UI (Inspired by Fish/Oh-My-Fish's BobTheFish theme"
    echo -e "\n#Prompt UI\n#PROMPT=\"%K{#333333}%M@%B %F{yellow}%1~ #%f %b%k\"\nPROMPT=\"%K{#333333}%M@%B %F{green}%1~ #%f %b%k\"\n" >> "${zshConfigFile}"

}


#################################################
# Alias related
function setupBasicAliases() {

    echo -en '
# general aliases adding color
alias ls="ls --color=auto --group-directories-first"
alias grep="grep --color=auto"

alias pkill="sudo pkill -9"
alias mkdir="mkdir -pv"

# custom aliases
alias a="sudo apt"
alias hc="history --delete"
alias SS="sudeo systemctl"
alias process="ps aux | grep"
alias ytd="yt-dlp"
# double check this when comcast is back
alias ytda="yt-dlp -x --audio-format mp3 --audio-quality 192kb "
' >> "${zshConfigFile}"
}

function setupGitAliases() {

   echo -en '
# git aliases
alias gck="git checkout"
alias gc="git commit"
# probably not needed
alias gcm="git commit -m"
alias gbD="git branch -D"
# "git add and clear"
alias gac="git add . -- && clear"


' >> "${zshConfigFile}"
}



## run functions
intialTasks
backupZSHRC
#clearZSHRC

ohmyzshPlugins
zshUserPlugins

createHistoryLocation
setupPrompt
setupBasicAliases
setupGitAliases
