zshConfigDir="~/.config/zsh"
zshConfigFile="~/.zshrc"

# TODO: backup existing zshrc file if it exists 



function downloadPlugin() {
    

    for currentPlugin in "${@}"
    do 

        echo -e "repoName:\t${repoName}"
        # from ohmhzsh repo 
        [ "${repoName}" == "ohmyzsh" ] && rawPlugin="https://raw.githubusercontent.com/${repoName}/${repoName}/master/plugins/${currentPlugin}/${currentPlugin}.plugin.zsh"
    

        # from zsh-users repo 
        [ "${repoName}" == "zsh-users" ] && rawPlugin="https://raw.githubusercontent.com/${repoName}/${currentPlugin}/master/${currentPlugin}.zsh"


        echo -e "${rawPlugin}"
        
        wget =s -P "assets/" "${rawPlugin}" 
        sleep 1 


    done 

}

function setupPlugins() {
    
    #echo -e "Copying zsh plugins to config location"
    #cp assets/config/zsh ~/.config/zsh/

    echo -e "Setting up plugins in .zshrc file"
    echo -e "#Include Plugins\t"

    for currentPlugin in "${@}"
    do 
        #echo -e "source ${zshConfigDir}/${currentPlugin}/${currentPlugin}.plugin.zsh" >> ${zshConfigFile}
        echo -e "source ${zshConfigDir}/${currentPlugin}/${currentPlugin}.plugin.zsh" 

    done 


}


function ohmyzshPlugins() { 
    # - DirHistory: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory
    # - sudo: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo

    repoName="ohmyzsh"

    downloadPlugin "dirhistory" "sudo"
}

function zshUserPlugins() {
    ## [zsh-users](https://github.com/zsh-users)

    # Sources 
    # zsh-autosuggestion: https://github.com/zsh-users/zsh-autosuggestions
    # zsh-history-substring-search: https://github.com/zsh-users/zsh-history-substring-search
    # zsh-syntax-highlighting: https://github.com/zsh-users/zsh-syntax-highlighting

    repoName="zsh-users"

    downloadPlugin "zsh-autosuggestions" "zsh-history-substring-search" "zsh-syntax-highlighting"

}

ohmyzshPlugins
zshUserPlugins

# Set up zsh history 
function createHistoryLocation() {
    cacheDir="~/.cache/.zsh/"
    zshHistoryFile="${cacheDir}/history"

    echo -e "Creating History file to use"

    [ ! -d "${cacheDir}" ] &&  mkdir "${cacheDir}" 

    touch "${zshHistoryFile}"

    # History in cache directory:
    echo "# History file\nHISTFILE=~/.cache/zsh/history" > ${zshConfigFile}
    
}




# Setip Prompt/Theme
function setupPrompt() {
    
    # NOTE TO SELF: remember to use \" for the lines below when echoing out
    echo "Setting up Prompt UI (Inspired by Fish/Oh-My-Fish's BobTheFish theme"
    echo "#Prompt UI\n#PROMPT=\"%K{#333333}%M@%B %F{yellow}%1~ #%f %b%k\"\nPROMPT=\"%K{#333333}%M@%B %F{green}%1~ #%f %b%k\"\n"
    
}

#################################################
# Alias related 
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
