#!/bin/bash

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

