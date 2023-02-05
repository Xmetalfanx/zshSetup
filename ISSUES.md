# Arch based distros

- With the OMZ plugin on arch you may get a complaint about "compdef" not being found.
    The fix: add the following code above the git function call 

    ```
    autoload -Uz compinit

    compinit
    ```