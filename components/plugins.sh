#!/bin/bash

# download plugins from the zsh-users repo
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

function omzSettings() {
    # for counter 
    [ ! -d "settings" ] && echo "Creating settings Directory" && mkdir "settings"

    # create settings file or reading settings file depending on if it exists 
    if [ ! -f "${settingsFile}" ]; then
        echo "Creating settings file" && touch "${settingsFile}"
    elif [ -f "${settingsFile}" ]; then
        echo "Reading Settings file" && . "${settingsFile}"
    fi 

}

# setup .zshrc file with the downloaded plugins 
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

# download plugins from the ohmyzsh repo 
function downloadOhMyZSHPlugin() {
    # here "repoName" is set already
    # load vars 
    loadOMZVars

    omzSettings

    downloadOhMyZSH

    for currentPlugin in "${@}"
    do
        currentPluginLocalDir="${localOhMyZshPluginsDir}${currentPlugin}"

        [ -d "${currentPluginLocalDir}" ] && echo -e "Copying ${currentPluginLocalDir} to ${zshConfigDir}"
        cp -r "${currentPluginLocalDir}" "${zshConfigDir}"

    done

    setupPlugins "${@}"
}


############################################################################

# Plugins that may not work on all distros by default anyway
# this will probably be renamed later 
function ohmyzshPlugins_distroSpecific() {
    # Repo:
    # colored-man-pages: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages

    repoName="ohmyzsh"

    #downloadOhMyZSHPlugin "colored-man-pages"

}

# The "Default" OMZ plugin function
function ohmyzshPlugins() {
    # Repo:
    # colorize: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize
    # sudo: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo

    repoName="ohmyzsh"

    downloadOhMyZSHPlugin "colorize" "sudo"

    ohmyzshPlugins_distroSpecific

    echo -e "OhMyZsh Plugins Added\v"

}

function zshUserPlugins() {
    ## Repo: [zsh-users](https://github.com/zsh-users)

    # Sources
    # zsh-completions: https://github.com/zsh-users/zsh-completions
    # zsh-autosuggestion: https://github.com/zsh-users/zsh-autosuggestions
    # zsh-history-substring-search: https://github.com/zsh-users/zsh-history-substring-search
    # zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting

    repoName="zsh-users"

   #downloadZshusersPlugin "zsh-completions" "zsh-autosuggestions" "zsh-history-substring-search" "zsh-syntax-highlighting"
    downloadZshusersPlugin  "zsh-autosuggestions" "zsh-syntax-highlighting"

    echo -e "zsh-users Plugins Added\v"
}


# Source: https://github.com/marlonrichert/zsh-autocomplete
function zshPluginAutoComplete() {
    repoName="marlonrichert"
    downloadZshusersPlugin "zsh-autocomplete"
}

##############################################################################
# testing
function ohmyzshPluginsTest() {
    # Repo:
    # colored-man-pages: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages

    repoName="ohmyzsh"

    downloadOhMyZSHPlugin "colored-man-pages"
}
