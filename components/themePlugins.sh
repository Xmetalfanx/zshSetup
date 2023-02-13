
function ohmyzshThemeInstall() {
    # load vars
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
        echo "source ${ZSHThemeLocation}${themeFileName}" >> ${zshConfigFile}
    done 
}

function installAgnosterTheme() {
    # setopt promptsubs    may  need to be added to zshrc file too 
    
    themeName="agnoster"

    echo -e "\n# Theming\nsetopt promptsubst" >> ${zshConfigFile}
    ohmyzshThemeInstall ${themeName}


}