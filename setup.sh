#!/bin/bash

zshConfigDir="/home/${USER}/.config/zsh"
zshConfigFile="/home/${USER}/.zshrc"


function backupZSHRC() {
    echo -e "Backing up existing zshrc"
    cp "${zshConfigFile}" "${zshConfigFile}.backup"

}
backupZSHRC

function clearZSHRC() {
    /dev/null > ${zshConfigFile}
}
clearZSHRC



#########################################################################################

# Plugin related 


# TODO: backup existing zshrc file if it exists 

# zsh-users is fine 
# ohmyzsh has plugins in a sub-folder ... that may be an issue 

function userPrompt() {
    read -p "Press Any Key to continue"
}


function downloadZshusersPlugin() {
    pluginName=${1}

    localZshUsersDir="${zshConfigDir}/${pluginName}"
    
    for currentPlugin in "${@}"
        do 
            # https://github.com/zsh-users/zsh-autosuggestions
            # zsh-users
            gitPluginURL="https://github.com/${repoName}/${currentPlugin}"
            
            echo -e "Downloading ${currentPlugin} to ${zshConfigDir}"
            [ ! -d "${localZshUsersDir}" ] && git clone -q "${gitPluginURL}" "${zshConfigDir}/${currentPlugin}"
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

        # for debugging 
        #ls -al ${zshConfigDir}

    done 

    setupPlugins "${@}"
}


# setup .zshrc file 
function setupPlugins() {
    
    echo -e "Setting up plugins in .zshrc file"
    
    for currentPlugin in "${@}"
    do 
        currentPluginScriptFile="${zshConfigDir}/${currentPlugin}/${currentPlugin}.plugin.zsh"
        echo -e "${currentPluginScriptFile}\v"
        
        echo -e "setting up ${currentPlugin} in zsh config file "
        echo -e "source ${currentPluginScriptFile}" >> ${zshConfigFile}
        sleep 2
    done 

}


##################################################################################3
# functions that use the functions above 

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

ohmyzshPlugins
zshUserPlugins

# Plugin related 
#####################################################################

##################################################################################################


# Set up zsh history 
function createHistoryLocation() {
    cacheDir="/home/${USER}/.cache/.zsh/"
    zshHistoryFile="${cacheDir}/history"

    echo -e "Creating History file to use"

    [ ! -d "${cacheDir}" ] &&  mkdir "${cacheDir}" 

    touch "${zshHistoryFile}"

    # History in cache directory:
    echo -e "# History file\nHISTFILE=~/.cache/zsh/history" > "${zshConfigFile}"
    
}


# Setip Prompt/Theme
function setupPrompt() {
    
    # NOTE TO SELF: remember to use \" for the lines below when echoing out
    echo -e "Setting up Prompt UI (Inspired by Fish/Oh-My-Fish's BobTheFish theme"
    echo -e "\n#Prompt UI\n#PROMPT=\"%K{#333333}%M@%B %F{yellow}%1~ #%f %b%k\"\nPROMPT=\"%K{#333333}%M@%B %F{green}%1~ #%f %b%k\"\n" >> ${zshConfigFile}
    
}
setupPrompt

#################################################
# Alias related 
function setupBasicAliases() {

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

}

function setupGitAliases() { 
    # git aliases 
    alias gck="git checkout"
    alias gc="git commit"
    # probably not needed
    alias gcm="git commit -m"
    alias gbD="git branch -D"
    # "git add and clear"
    alias gac="git add . -- && clear"

    # i dont want to mess up git repos but could i combine aliases?
    # example - gacm="gac && gcm" ' ... so then i'd type ' gacm "foobar message"    '
}


source ~/.zshrc