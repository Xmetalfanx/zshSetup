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

    backupZSHRC

    echo -e "Clearing out existing zsh file "
    > ${zshConfigFile}
}

# End of Genral Tasks
################################################################################

################################################################################
# Plugin Related Code

#sort of used in debugging so i can pause the screen 
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

            gitPluginURL=""

        done

        setupPlugins "${@}"
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

    # Repo: 
    # - DirHistory: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory
    # git - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
    # - sudo: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo

    repoName="ohmyzsh"

    downloadOhMyZSHPlugin "dirhistory" "git" "sudo"
}

function zshUserPlugins() {
    ## Repo: [zsh-users](https://github.com/zsh-users)

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

    echo -e "Creating History file to use" && userPrompt

    # look for cache dir and create it if it doesn't exist, along with the history file and crate that if it doesn't exist
    [ ! -d "${cacheDir}" ] &&  mkdir "${cacheDir}" && [ ! -f "${zshHistoryFile}" ] && touch "${zshHistoryFile}"

    # History in cache directory:
    echo -e "\n# History file\nHISTFILE=~/.cache/zsh/history" >> "${zshConfigFile}"

}
###########################################################################################3
# Theme Related 


# PROMPT = PS1 ... SAME THING 
    # %n = name 
    # %M = name + machine
    # %1= name of pwd (no path)
    # %@ = time 

darkgrey="#333333"
machineName="%M"
currentDir="%1"


function bobTheFishStyleTheme() {
    PROMPT="%K{${darkgrey}}${machineName}@%B %F{yellow}${currentDir}~ #%f %b%k"
    #PROMPT="%K{${darkgrey}}%M@%B %F{green}${currentDir}~ #%f %b%k"

}

function christmasPromptTheme() {
   
    # christmas
    PROMPT="%K{#006400}%F{white}%M%f@ %B%F{#ff0000}%1~ #%f %b%k"

}


# Setip Prompt/Theme
function setupPromptTheme() {
    bobTheFishStyleTheme

    echo -e "Setting up Prompt UI (Inspired by Fish/Oh-My-Fish's BobTheFish theme" && userPrompt
    echo -e "\n#Prompt UI\nPROMPT=\"${PROMPT}\"\n" >> "${zshConfigFile}"

}


#################################################
# Alias related
function setupBasicAliases() {

    echo -en '# general aliases adding color
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
clearZSHRC

# Add Plugins 
#ohmyzshPlugins && zshUserPlugins && userPrompt

createHistoryLocation && setupPromptTheme


# Setup Aliases 
echo  "Setting up Aliases" && userPrompt && setupBasicAliases