zshConfigDir="~/.config/zsh/"
zshConfigFile="~/.zshrc"
testDir="${pwd}/test/"

# TODO: backup existing zshrc file if it exists 



function addPlugin() {

    # https://raw.githubusercontent.com/zsh-users/zsh-autosuggestions/master/zsh-autosuggestions.zsh

    
    pluginName="${1}"

    # from ohmhzsh

    # wrong -   https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh
    # correct - https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/sudo/sudo.plugin.zsh


    [ "${repoName}" == "ohmyzsh" ] && rawPlugin="https://raw.githubusercontent.com/${repoName}/${repoName}/master/plugins/${pluginName}/${pluginName}.plugin.zsh"
    

  
    [ "${repoName}" == "zsh-user" ] && rawPlugin="https://raw.githubusercontent.com/${repoName}/${pluginName}/master/${pluginName}.zsh"


    echo -e "${pluginName}"
    echo -e "${rawPlugin}"
    curl -s ${rawPlugin} -o "${pluginName}.plugin.sh"
    sleep 1 

}

function ohmyzshPlugins() { 
    repoName="ohmyzsh"

    # - DirHistory: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory
    # - sudo: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo



    addPlugin "dirhistory"

    # correct - https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/dirhistory/dirhistory.plugin.zsh


    addPlugin "sudo"

}

function zshUserPlugins() {
    ## [zsh-users](https://github.com/zsh-users)

    # - zsh-autosuggestion: https://github.com/zsh-users/zsh-autosuggestions
        ## correct link - https://raw.githubusercontent.com/zsh-users/zsh-autosuggestions/master/zsh-autosuggestions.zsh
    # - zsh-history-substring-search: https://github.com/zsh-users/zsh-history-substring-search
    # - zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting

    repoName="zsh-users"

    addPlugin "zsh-autosuggestions"
    addPlugin "zsh-history-substring-search"
    addPlugin "zsh-syntax-highlighting"

}

ohmyzshPlugins
#zshUserPlugins

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
