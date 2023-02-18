#!/bin/bash
source "components/themePlugins.sh"


###########################################################################################3
# Theme Related

# help from https://blog.sellorm.com/2020/01/13/add-the-current-git-branch-to-your-bash-prompt/ used
# possible helpful resource: https://www.tecmint.com/customize-bash-colors-terminal-prompt-linux/

function themeVars() {

    showGitBranch="(\$(git symbolic-ref --short HEAD 2>/dev/null))"

    # PROMPT = PS1 ... SAME THING
    # %n = name
    # %M = name + machine
    # %1= name of pwd (no path)
    # %@ = time

    darkgrey="#333333"
    machineName="%M"
    currentDir="%1"

    yellow="%F{yellow}"
    green="%F{green}"
    white="%F{white}"
    red="%F{#FF0000}"
    blue="%F{#0000FF}"
    green="%F{#006400}"
}

themeVars

# function to pass custom themes to 
function assembleBobTheFishTheme() {
    # sections assembled
    machineSection="${machineBGColor}}${machineName}@%B"
    pwdSection="${pwdFGColor}${currentDir}~"
    gitSection="${gitBranchFGColor}${showGitBranch}${pwdFGColor}"

    PROMPT="%K{${machineSection} ${pwdSection} ${gitSection}>%f %b%k"

    #echo -e "${theme}"
}


function BobTheFishInspired2() {

    # section colors
    machineBGColor=${darkgrey}
    pwdFGColor=${green}
    gitBranchFGColor=${white}
}


function BobTheFishInspired1() {
   # section colors
    machineBGColor=${darkgrey}
    pwdFGColor=${yellow}
    gitBranchFGColor=${green}
}

function BobTheFishInspired3() {
   # section colors
    machineBGColor=${darkgrey}
    pwdFGColor=${green}
    gitBranchFGColor=${white}
}

# Blue and red try 
function BobTheFishInspiredBlueRed() {
       # section colors
    machineBGColor=${darkgrey}
    pwdFGColor=${blue}
    gitBranchFGColor=${red}
}

function christmasPromptTheme() {
    # this theme seems different so i may have to use a custom template for it 
    # christmas
    PROMPT="%K{#006400}${white}%M%f@ %B${red}%1~ #%f %b%k"

}

# Setip Prompt/Theme
function setupPromptTheme() {
    # theme to use
    BobTheFishInspired3

    # generate theme
    assembleBobTheFishTheme

    echo -e "Setting up Prompt UI (Inspired by Fish/Oh-My-Fish's BobTheFish theme" && userPrompt
    echo -e "\n#Prompt UI\nPROMPT=\"${PROMPT}\"\n" >> "${zshConfigFile}"
}





# HELPFUL LINK: https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html


#############################################################################3
# Differentiate Root User From Normal User

# The normal BASH prompt displays a $ sign for a normal user. If you log in as a root user, a # sign is displayed. Use the $ code to indicate that the current user is not a root user:

# export PS1="\u@\H \W:\$ "


function generateThemeSection(){
    #$1 - sectionName
    #$2 - sectionColor
    #$3 - sectionCode

    sectionName="${1}"
    sectionColor="${2}"
    sectionCode="${3}"
    
    sectionComplete="%F{${sectionColor}}${sectionCode}f"

    echo -e "sectionComplete:\t${sectionComplete}"
    sleep 2
}

# source: https://stackoverflow.com/questions/1128496/to-get-a-prompt-which-indicates-git-branch-in-zsh
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# before refactoring attempt 
function freshThemeTry1() {   
    # NAMECODE="%n > "
    # NAMEBGCOLOR="#333333"
    # NAMEFGCOLOR="orange"
    # NAMECOMPLETE="%K{${NAMEBGCOLOR}}%F{${NAMEFGCOLOR}}${NAMECODE}%f%k" 
    
    # DATECODE="%*"
    # DATEFGCOLOR="white"
    # DATECOMPLETE="%F{${DATEFGCOLOR}}${DATECODE}%f"

    FULLPATHCODE="%~"
    FULLPATHBGCOLOR="#333333"
    FULLPATHFGCOLOR="white"
    FULLPATHCOMPLETE="%K{${FULLPATHBGCOLOR}}%F{${FULLPATHFGCOLOR}}${FULLPATHCODE}%f%k >"

    # displays pwd and parent (@ 2d)
    PWDCODE="%1d"
    PWDBGCOLOR="#3333333"
    PWDFGCOLOR="white"
    PWDCOMPLETE="%K{${PWDBGCOLOR}}%F{${PWDFGCOLOR}}${PWDCODE}%f%k >"

    GITBRANCHCODE='$vcs_info_msg_0_'
    GITBRANCHBGCOLOR="#3333333"
    GITBRANCHFGCOLOR="green"
    GITBRANCHCOMPLETE="%K{${GITBRANCHBGCOLOR}}%F{${GITBRANCHFGCOLOR}}${GITBRANCHCODE}%f%k "

    PROMPT="%B${FULLPATHCOMPLETE} ${GITBRANCHCOMPLETE}%b> "


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

# lets user pick between my default theme (a WIP) or Agnoster
function themeChooser(){
    clear
    echo -en "Theme Chooser
Which theme would you like to use?
1) My Custom Theme - no need for a plugin
2) OhMyZsh's version of the Agnoster Theme"
read -p "Your Choice (1/2): " themeSelection

    case $themeSelection in 
        1) freshThemeTry1 ;;
        2) installAgnosterTheme ;;
        *) echo "invalid selection" ;; 
    esac 

}
