#!/bin/bash
source "components/themePlugins.sh"


###########################################################################################3
# Theme Related

# help from https://blog.sellorm.com/2020/01/13/add-the-current-git-branch-to-your-bash-prompt/ used
# possible helpful resource: https://www.tecmint.com/customize-bash-colors-terminal-prompt-linux/

function themeVars() {

    DEFAULTBGCOLOR="%K{#333333}"

    # Background Colors
    yellowBGColor="%K{yellow}"
    greenBGColor="%K{green}"
    whiteBGColor="%K{#FFFFFF}"
    redBGColor="%K{#FF0000}"
    blueBGColor="%K{#0000FF}"
    greenBGColor="%K{#3dc21d}"


    # Forground Colors 
    yellowFGColor="%F{yellow}"
    greenFGColor="%F{green}"
    whiteFGColor="%F{#FFFFFF}"
    redFGColor="%F{#FF0000}"
    blueFGColor="%F{#0000FF}"
    greenFGColor="%F{#3dc21d}"

    ENDFGANDBGCOLOR="%f%k"
    ENDSECTION=" > ${ENDFGANDBGCOLOR}"


    # code for what to actually display 
    NAMECODE="%n"
    DATECODE="%*"
    FULLPATHCODE="%~"
    GITBRANCHCODE='$vcs_info_msg_0_'


    # displays pwd and parent (@ 2d)
    PWDCODE="%1d"
    

}
themeVars


#leftover function 
function setupPromptTheme() {

    echo -e "Setting up Prompt UI (Inspired by Fish/Oh-My-Fish's BobTheFish theme" && userPrompt
    echo -e "\n#Prompt UI\nPROMPT=\"${PROMPT}\"\n" >> "${zshConfigFile}"
}

############################################################################################
# Theme Generation 

# HELPFUL LINK: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html


function themeSectionSetupVars() {

    NAME=${NAMEBGCOLOR}${NAMEFGCOLOR}${NAMECODE}${ENDSECTION} 
    # DATE="%F{${DATEFGCOLOR}}${DATECODE}%f"
    FULLPATH=${FULLPATHBGCOLOR}${FULLPATHFGCOLOR}${FULLPATHCODE}${ENDSECTION}
    PWDPATH=${PWDBGCOLOR}${PWDFGCOLOR}${PWDCODE}${ENDSECTION}
    GITBRANCH=${GITBRANCHBGCOLOR}${GITBRANCHFGCOLOR}${GITBRANCHCODE}${ENDSECTION}

}


# outputs needed code for my custom themes to .zshrc
function echoThemeCodeToZSHRC() {
 echo "
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

zstyle ':vcs_info:git:*' formats '%b'

# VERY IMPORTANT: https://stackoverflow.com/questions/56449176/zsh-not-updating-vcs-info
# single quotes have to be used 
PROMPT='${PROMPT}'
" >> "/home/${USER}/.zshrc"

}



function generateXmetalTheme1() {

    themeSectionSetupVars

    PROMPT="%B${NAME}${GITBRANCH}%b"

    echoThemeCodeToZSHRC
}

function generateXmetalTheme2(){

    themeSectionSetupVars
    
    PROMPT="%B${NAME}${PWDPATH}${GITBRANCH}%b"

    echoThemeCodeToZSHRC
}



# Emd of Theme Generation code 
#############################################################################################





#######################################################################
# lets user pick between my default theme (a WIP) or Agnoster
function themeChooser(){
    clear
    echo -en "Theme Chooser
Which theme would you like to use?
1) OhMyZsh's version of the Agnoster Theme

Note: No Need for a plugin with these 
2) My first Custom Theme
3) My Second Custom Theme
"
read -p "Your Choice (1/2): " themeSelection

    case $themeSelection in 
        1) installAgnosterTheme  ;;
        2) xmetalTheme1 ;;
        3) xmetalTheme2 ;;
        *) echo "invalid selection" ;; 
    esac 

}

source "components/themes.sh"
