configDir="~/.config/.zsh"

source ~/.config/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/.zsh/dirhistory/dirhistory.plugin.zsh
source ~/.config/.zsh/sudo/sudo.plugin.zsh
source ~/.config/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.config/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh


# from youtuber Luke Smith: https://www.youtube.com/@LukeSmithxyz
# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
#PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
#setopt autocd		# Automatically cd into typed directory.
#stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

######################################################33

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

