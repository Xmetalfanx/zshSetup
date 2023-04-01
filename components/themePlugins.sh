#!/bin/bash

# This function can take multiple theme names 
# what gets passed?: JUST the theme name 
function ohmyzshThemeInstall() {
    # load variables needed 
    loadOMZVars

    # create theme dir if it is not there
    [ ! -d "${zshThemeDir}" ] && mkdir "${zshThemeDir}"

    downloadOhMyZSH


    for currentTheme in "${@}"
    do
        themeFileName="${currentTheme}.zsh-theme"
        # copy from assests folder location to config dir locations
        # themes are a single file 
        echo -e "Copying ${currentTheme} theme to zsh themes folder in ${ZSHThemeLocation} "
        cp "${localOhMyZshThemesDir}/${themeFileName}" "${ZSHThemeLocation}/${themeFileName}"

        # export into zshrc file 
        echo -e "Setting up ${currentTheme} in .zshrc file "
        echo "source ${ZSHThemeLocation}${themeFileName}" >> "${zshConfigFile}"
    done 
}

function installAgnosterTheme() {
    themeName="agnoster"

    clear
    echo -e "Moving needed file first"
    cp "${localOhMyZshDir}/lib/git.zsh" "${zshConfigDir}"

    echo -e "Sourcing needed file"
    echo -en "source ${zshConfigDir}/git.zsh" >> "${zshConfigFile}"

    echo -e "Setting up ${themeName} theme"
    echo -e "\n# Theming\nsetopt promptsubst" >> "${zshConfigFile}"
    ohmyzshThemeInstall ${themeName}


}