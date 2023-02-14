#!/bin/bash

function checkCommand() {

    # Checking if ${1} is installed, otherwise aliases for ${1} will NOT be added
    echo -e "Checking if ${1} is installed"

    [[ "$1" ]] && echo -e "${1} IS present" || echo -e "${1} is NOT present" || return

    # ?? where is it returning to?
}


#################################################
# Alias related
function setupBasicAliases() {
    echo "Setting up basic aliases"

echo -en '\n# general aliases adding color
alias grep="grep --color=auto"

alias pkill="sudo pkill -9"
alias mkdir="mkdir -pv"

# custom aliases
alias a="sudo apt"
alias hc="history --delete"
alias SS="sudeo systemctl"
alias process="ps aux | grep"

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"

# from ohmyzsh
alias p="ps -f"
alias zshrc="${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc" # Quick access to the .zshrc file
alias dud="du -d 1 -h"
(( $+commands[duf] )) || alias duf="du -sh *"
(( $+commands[fd] )) || alias fd="find . -type d -name"
alias ff="find . -type f -name"


' >> "${zshConfigFile}"
}

function setupLsAliases() {
    checkCommand "ls"
    echo -e "Seting up ls related aliases" 
echo -en '
# ls aliases
alias ls="ls --color=auto --group-directories-first"
alias lal="ls --color=auto --group-directories-first -alh"

# ls, the common ones I use a lot shortened for rapid fire usage
alias l="ls -lFh"     #size,show type,human readable
alias la="ls -lAFh"   #long list,show almost all,show type,human readable
alias lr="ls -tRFh"   #sorted by date,recursive,show type,human readable
alias lt="ls -ltFh"   #long list,sorted by date,show type,human readable
alias ll="ls -l"      #long list

alias lsr="ls -lARFh" #Recursive list of files and directories
alias lsn="ls -1"     #A column contains name of files and directories

' >> "${zshConfigFile}"
}

function setupYtdlpAliases() {

    checkCommand "yt-dlp"
    echo "Setting up yt-dlp aliases"

echo -en '# yt-dlp aliases
alias ytd="yt-dlp"
# double check this when comcast is back
alias ytda="yt-dlp -x --audio-format mp3 --audio-quality 192kb "
' >> "${zshConfigFile}"
}


function setupGitAliases() {
    checkCommand "git"
    echo "Setting up git related aliases"

echo -en '# git aliases
alias gck="git checkout"

# git branch
alias gbd="git branch --delete"
alias gbr="git branch --remote"

# git commit
alias gc="git commit"
alias gcm="git commit -m"
alias gcam="git commit --all --message"
alias gcsm="git commit --signoff --message"
alias gcas="git commit --all --signoff"
alias gcasm="git commit --all --signoff --message"
alias gcs="git commit --gpg-sign"
alias gcss="git commit --gpg-sign --signoff"
alias gcssm="git commit --gpg-sign --signoff --message"

alias gac="git add . -- && clear"

# git checkout 
alias gco="git checkout"

# git config 
alias gcf="git config --list"

# git push 
alias gp="git push"
alias gpd="git push --dry-run"
alias gpv="git push --verbose"

# git status
alias gss="git status --short"
alias gst="git status"

# git tag
alias gts="git tag --sign"
alias gtv="git tag | sort -V"

' >> "${zshConfigFile}"
}


function setupHistoryAliases() {

    checkCommand "history"
    echo -e "Setting up history related aliases"

echo -en '# history aliases
alias h="history"
alias hs="history | grep"
alias hsi="history | grep -i"
' >> "${zshConfigFile}"

}

function setupYarnAliases() {
 checkCommand "yarn"
 echo "Setting up yarn related aliases"

echo -en '# yarn aliases
alias ya="yarn add"
alias yad="yarn add --dev"
alias ycc="yarn cache clean"
alias ygls="yarn global list"
alias ygrm="yarn global remove"
alias ygu="yarn global upgrade"
alias yin="yarn install"
alias yls="yarn list"
alias yout="yarn outdated"
alias yrm="yarn remove"
alias yuc="yarn global upgrade && yarn cache clean"
alias yui="yarn upgrade-interactive"
alias yuil="yarn upgrade-interactive --latest"
alias yup="yarn upgrade"
' >> "${zshConfigFile}"
}


function metaAliasSetup() {

    echo  "Setting up Aliases"
    setupBasicAliases
    setupLsAliases
    setupGitAliases
    setupHistoryAliases
    setupYtdlpAliases
    setupYarnAliases
}