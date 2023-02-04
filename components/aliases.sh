#!/bin/bash

#################################################
# Alias related
function setupBasicAliases() {

    echo -en '# general aliases adding color
alias ls="ls --color=auto --group-directories-first"
alias grep="grep --color=auto"

alias pkill="sudo pkill -9"
alias mkdir="mkdir -pv"

# custom aliases
alias a="sudo apt"
alias hc="history --delete"
alias SS="sudeo systemctl"
alias process="ps aux | grep"
alias ytd="yt-dlp"
# double check this when comcast is back
alias ytda="yt-dlp -x --audio-format mp3 --audio-quality 192kb "
' >> "${zshConfigFile}"
}

# not needed with plugin
function setupGitAliases() {

   echo -en '
# git aliases
alias gck="git checkout"
alias gc="git commit"
# probably not needed
alias gcm="git commit -m"
alias gbD="git branch -D"
# "git add and clear"
alias gac="git add . -- && clear"

' >> "${zshConfigFile}"
}
