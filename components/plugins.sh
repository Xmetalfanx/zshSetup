#!/bin/bash

function setupZSHConfigDirectory() {
    [ ! -d "${zshConfigDir}" ] && echo -e "${zshConfigDir} doesn't exist, creating now" && mkdir "${zshConfigDir}"
}

function removeGitFolder() {
    echo "Removing .git folder from local plugin directory " && rm -rf "${localZshUsersDir}/.git"
}

# download plugins from the zsh-users repo
# April 2023: this works for more than just this repo 
function downloadZshPlugin() {

    # zshConfigDir is the config dir in ~/.config/ .... ~/.config/zsh 
    #localZshUsersDir="${zshConfigDir}/${pluginName}"

    for currentPlugin in "${@}"
        do
            # April 2023: WHY is this redeclared here? 
            localZshUsersDir="${zshConfigDir}/${currentPlugin}"

            # https://github.com/zsh-users/zsh-autosuggestions
            # zsh-users
            gitPluginURL="https://github.com/${repoName}/${currentPlugin}"

            [ -d "${localZshUsersDir}" ] && rm -rf "${localZshUsersDir}"

            echo -e "Downloading ${currentPlugin} to ${zshConfigDir}"

            git clone -q --depth=1 "${gitPluginURL}" "${localZshUsersDir}"

            removeGitFolder
            
            gitPluginURL=""

        done

        setupPlugins "${@}"
}

# creating/reading settings file that would control if OMZ would have to be redownloaded 
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

    # creating/reading settings file that would control if OMZ would have to be redownloaded 
    omzSettings

    #downloads OhMyZSH to assets folder "if needed"
    downloadOhMyZSH

    for currentPlugin in "${@}"
    do
        # this would be in say assets/ohmyzsh/plugins/<name> 
        currentPluginAssetsDir="${localOhMyZshPluginsDir}${currentPlugin}"
        
        currentPluginDestDir="${zshConfigDir}"

        # Sets up ~/.config/zsh if its not there 
        setupZSHConfigDirectory
        
        # if the plugin folder doesn't exist in the assets folder (could mean a typo)
        [ -d "${currentPluginAssetsDir}" ] || echo -e "${currentPluginAssetsDir} not found, check for typos in the plugin name you wanted to install"  || return 
        
        [ ! -d "${zshConfigDir}" ] && echo "${zshConfigDir} not found"

        # creates needed dir for where to put the plugin
        [ ! -d "${currentPluginDestDir}" ] && echo "Creating ${currentPluginDestDir} directory" && mkdir "${currentPluginDestDir}"
        
        echo -e "Copying ${currentPluginAssetsDir} to ${currentPluginDestDir}" && cp -a "${currentPluginAssetsDir}" "${currentPluginDestDir}"

        removeGitFolder

    done

    setupPlugins "${@}"


}


############################################################################

# The "Default" OMZ plugin function
function ohmyzshPlugins() {
    # Repo:
    # colorize: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize
    # sudo: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo

    repoName="ohmyzsh"

    # "Check" for fzf  
	if [ $(command -v fzf) ]; then 
        echo "Fuzzy find package fzf detected as installed" 
    else 
        echo -e "fzf fuzzy find, not detected, installing now" && $install "fzf"
    fi 


    downloadOhMyZSHPlugin "colorize" "fzf" "sudo" 

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

    downloadZshPlugin "zsh-autosuggestions" "zsh-syntax-highlighting"

    echo -e "zsh-users Plugins Added\v"
}

function zshPluginAutoComplete() {
    # Repo: [marlonrichert](https://github.com/marlonrichert/zsh-autocomplete)

    repoName="marlonrichert"
    downloadZshPlugin "zsh-autocomplete"

    echo -e "zsh-autocomplete plugin from ${repoName} Added\v"
}

function coloredManPages() {
    # Repo: [zsh-colored-man-pages](https://github.com/ael-code/zsh-colored-man-pages)

    coloredManPagesConfigDir="${zshConfigDir}/zsh-colored-man-pages/"

    repoName="ael-code"
    downloadZshPlugin "zsh-colored-man-pages"
     
    [ -f "${coloredManPagesConfigDir}/colored-man-pages.plugin.zsh" ] && echo "Rename fix applied" && mv "${coloredManPagesConfigDir}/colored-man-pages.plugin.zsh" "${coloredManPagesConfigDir}/zsh-colored-man-pages.plugin.zsh" && userPrompt

    echo -e "colored-man-pages from ${repoName} repo Added\v"
}
