zshConfigDir="~/.config/zsh/"
zshConfigFile="~/.zshrc"


function createHistoryLocation() {
    cacheDir="~/.cache/.zsh/"
    zshHistoryFile="${cacheDir}/history"

    echo -e "Creating History file to use"

    [ ! -d "${cacheDir}" ] &&  mkdir "${cacheDir}" 

    touch "${zshHistoryFile}"

    # History in cache directory:
    echo "# History file\nHISTFILE=~/.cache/zsh/history" > ${zshConfigFile}
    
}

function setupPlugins() {
    echo -e "Copying zsh plugins to config location"
    cp assets/config/zsh ~/.config/zsh/

    echo -e "Setting up plugins in .zshrc file"
    echo "# Plugins\nsource ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh\nsource ~/.config/zsh/zsh-history-substring-search/zsh-history-substring-search.zsh\nsource ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ${zshConfigFile}

}

function setupPrompt() {
    
    # NOTE TO SELF: remember to use \" for the lines below when echoing out
    echo "Setting up Prompt UI (Inspired by Fish/Oh-My-Fish's BobTheFish theme"
    echo "#Prompt UI\n#PROMPT=\"%K{#333333}%M@%B %F{yellow}%1~ #%f %b%k\"\nPROMPT=\"%K{#333333}%M@%B %F{green}%1~ #%f %b%k\"\n"
    
}

function setupBasicAliases() {

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

}


function setupGitAliases() { 
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

}
