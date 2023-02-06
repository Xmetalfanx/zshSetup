#!/bin/bash

################################################################################
# Plugin Related Code

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

# download plugins from the ohmyzsh repo 
function downloadOhMyZSHPlugin() {
    # here "repoName" is set already
    ohmyzshRepo="https://github.com/ohmyzsh/ohmyzsh.git"
    # where to put downloaded omz plugin
    localOhMyZshDir="assets/ohmyzsh"
    settingsFile="settings/settings.cfg"
    ohmyzshPluginsDir="${localOhMyZshDir}/plugins/"

    omzSettings

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


    for currentPlugin in "${@}"
    do
        currentPluginLocalDir="${ohmyzshPluginsDir}${currentPlugin}"

        [ -d "${currentPluginLocalDir}" ] && echo -e "Copying ${currentPluginLocalDir} to ${zshConfigDir}"
        cp -r "${currentPluginLocalDir}" "${zshConfigDir}"

    done

    setupPlugins "${@}"
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

############################################################################

# Plugins that may not work on all distros by default anyway
function ohmyzshPlugins_havingIssues() { 
    # Repo:
    # colored-man-pages: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colored-man-pages
    # colorize: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize

    # colorize doesn't always work on non-Ubuntu distros (* by default) in my tests and I cant get colored-man-pages to work even though i DID see it working once before I started these scripts 

    repoName="ohmyzsh"

    downloadOhMyZSHPlugin "colorize" "colored-man-pages"
}


# The "Default" OMZ plugin function 
function ohmyzshPlugins() {
    # Repo:
    # dirhistory: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory
    # sudo: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo

    repoName="ohmyzsh"

    downloadOhMyZSHPlugin "dirhistory" "sudo"
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
