#!/bin/bash

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

    [ ! -d "${localOhMyZshDir}" ] && git clone -q "${ohmyzshRepo}" "${localOhMyZshDir}"

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
    # colored-man-pages: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages
    # colorize: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize
    # common-aliases: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/common-aliases
    # dirhistory: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory
    # history: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/history
    # git - https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git
    # sudo: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo
    # systemd: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/systemd
    # yarn: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/yarn

    repoName="ohmyzsh"

    downloadOhMyZSHPlugin "colorize" "colored-man-pages" "common-aliases" "dirhistory" "history" "git" "sudo" "systemd" "yarn"
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
