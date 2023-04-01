#!/bin/bash
source "components/themePlugins.sh"

# help from https://blog.sellorm.com/2020/01/13/add-the-current-git-branch-to-your-bash-prompt/ used
# possible helpful resource: https://www.tecmint.com/customize-bash-colors-terminal-prompt-linux/


###########################################################################################3
# Theme Related

# NOTE: this is only for the start of the line and an ending %k shouldn't be here 
function generateBGColorCode() {
    echo -e "%K{${1}}"
}

# generate FG Color code: like the BG function if this had a %f than the color code "ends" before the text, so it shouldn't have a closing %f, here 
function generateFGColorCode() {
    echo -e "%F{${1}}"
}



# Assign Variables
function themeVars() {

    DEFAULTBGCOLOR=$(generateBGColorCode "#333333")

    # Background Colors
    blackBG=$(generateBGColorCode "#000000")
    blueBG=$(generateBGColorCode "#0000FF")
    neonGreenBG=$(generateBGColorCode "#39ff14")
    orangeBG=$(generateBGColorCode "#FF791A")
    redBG=$(generateBGColorCode "#FF0000")
    whiteBG=$(generateBGColorCode "#FFFFFF")
    yellowBG=$(generateBGColorCode "yellow")
    
    # Forground Colors 
    
    blueFG=$(generateFGColorCode "#0000FF")
    neonGreenFG=$(generateFGColorCode "#39ff14")
    orangeFG=$(generateFGColorCode "#FF791A")
    redFG=$(generateFGColorCode "#FF0000")
    whiteFG=$(generateFGColorCode "#FFFFFF")
    yellowFG=$(generateFGColorCode "yellow")

    ENDFGANDBGCOLOR="%f%k"
    ENDSECTION=" > ${ENDFGANDBGCOLOR}"


    # code for what to actually display 
    NAMECODE="%n"
    DATECODE="%*"
    FULLPATHCODE="%~"
    # was there a reason this had to be in single quotes (i get "errors on code checkers" but i think i needed this, this way )
    GITBRANCHCODE='$vcs_info_msg_0_'


    # displays pwd and parent (@ 2d)
    PWDCODE="%1d"
    

}
themeVars


############################################################################################
# Theme Generation

# HELPFUL LINK: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html


function debuggingOutput() {
    echo -e "${NAME}\n${FULLPATH}\n${PWDPATH}"
    userPrompt
}

# Variables piecing the sections together
function themeSectionVarSetup() {

    NAME=${NAMEBGCOLOR}${NAMEFGCOLOR}${NAMECODE}${ENDSECTION}
    DATE="%F{${DATEFGCOLOR}}${DATECODE}%f"
    FULLPATH=${FULLPATHBGCOLOR}${FULLPATHFGCOLOR}${FULLPATHCODE}${ENDSECTION}
    PWDPATH=${PWDBGCOLOR}${PWDFGCOLOR}${PWDCODE}${ENDSECTION}

    clear

    # looks for git prompt folder and if found the GITBRANCH code in my themes is set to a blank to avoid the prompt showing 
    # the git branch twice 
    [ ! -d "${zshConfigDir}/git-prompt" ] && GITBRANCH="${GITBRANCHBGCOLOR}${GITBRANCHFGCOLOR}${GITBRANCHCODE}${ENDSECTION}" || GITBRANCH=""

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

##########################################################################

# the lopic in this is that the FORMAT can stay the same but different color vars can be passed
function generateXmetalTheme1() {

    themeSectionVarSetup
    PROMPT="%B${NAME}${GITBRANCH}%b"
    echoThemeCodeToZSHRC
}

function generateXmetalTheme2(){

    themeSectionVarSetup
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
read -rp "Your Choice (1/2): " themeSelection

    case $themeSelection in 
        1) installAgnosterTheme  ;;
        2) xmetalTheme1 ;;
        3) xmetalTheme2 ;;
        *) echo "invalid selection" ;; 
    esac 

}

source "components/themes.sh"
