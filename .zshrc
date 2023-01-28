
source ~/.config/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
#source ~/.config/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
#setopt autocd		# Automatically cd into typed directory.
#stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="robbyrussell"


# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"


# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git git-extras common-aliases history history-substring-search ubuntu)

# xmetal comment: i commented this out with no internet to disable oh my zsh .. undo to add it again
#source $ZSH/oh-my-zsh.sh

# User configuration

######################################################33
# Xmetal custom 
setopt MENU_COMPLETE NO_MATCH EXTENDED_GLOB

autoload -Uz colors && colors

# PROMPT = PS1 ... SAME THING 
    # %n = name 
    # %M = name + machine
    # %1= name of pwd (no path)
    # %@ = time 
darkgrey="{#333333}"
name_machine="%M"
currentDir="%1"

#PROMPT="%K{#333333}%M@%B %F{yellow}%1~ #%f %b%k"
PROMPT="%K{#333333}%M@%B %F{green}%1~ #%f %b%k"

# christmas
#PROMPT="%K{#006400}%F{white}%M%f@ %B%F{#ff0000}%1~ #%f %b%k"


# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history


# enable tab completion 
# autoload -U compinit
# zstyle ":completion:*" menu select
# zmodload zsh/complist
# compinit
# _comp_options+=(globdots)

###############################################3
# general aliases adding color 
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

# git aliases 
alias gck="git checkout"
alias gc="git commit"
# probably not needed
alias gcm="git commit -m"
alias gbD="git branch -D"
# "git add and clear"
alias gac="git add . -- && clear"

# i dont want to mess up git repos but could i combine aliases?
# example ' gacm="gac && gcm" ' ... so then i'd type ' gacm "foobar message"    '

source ~/.config/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
