#!/bin/bash

# source: https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/common-aliases/common-aliases.plugin.zsh
function omzAliasesCommonAliases() {
    # Advanced Aliases.
    # Use with caution

    alias p='ps -f'
    alias zshrc='${=EDITOR} ${ZDOTDIR:-$HOME}/.zshrc' # Quick access to the .zshrc file
    alias grep='grep --color'
    alias dud='du -d 1 -h'
    (( $+commands[duf] )) || alias duf='du -sh *'
    (( $+commands[fd] )) || alias fd='find . -type d -name'
    alias ff='find . -type f -name'
}