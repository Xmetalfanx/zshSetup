
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
