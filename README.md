# zshSetup

- [zshSetup](#zshsetup)
  - [Goal](#goal)
  - [How to run](#how-to-run)
  - [Setup Options](#setup-options)
  - [Screenshots](#screenshots)
  - [Credits](#credits)
  - [Plugins](#plugins)
    - [Oh-my-zsh](#oh-my-zsh)
    - [zsh-users](#zsh-users)
    - [zsh-autocomplete](#zsh-autocomplete)
    - [colored-man-pages](#colored-man-pages)
  - [Theming](#theming)
  - [Projects](#projects)


## Goal

While I may in fact do the same thing I did with my [Linux Setup Scripts](https://github.com/Xmetalfanx/linuxSetup). The goal for right now is similiar to the origins of that project. A way to setup zsh (Linux in the other case) fast on a fresh setup.

Menus and "Do you want to install A or B?" type things may come later but this is just a fast set of tasks I have tossed together for now .. again like the origins of my [Linux Setup Scripts](https://github.com/Xmetalfanx/linuxSetup).

## How to run

- Once downloaded, navigate to the zshSetup folder and type
  `bash setupZSH.sh`

## Setup Options

| Task Done                                        | Slim | Medium | NonTheme Complete | Complete |
| ------------------------------------------------ | ---- | ------ | ----------------- | -------- |
| Sets Up Aliases \*                               | Yes  | Yes    | Yes               | Yes      |
| Sets up zsh history file in ~/.cache/zsh/history | Yes  | Yes    | Yes               | Yes      |
| Sets up Prompt theme \*\*                        | No   | Yes    | No                | Yes      |
| Sets up various downloaded zsh plugins           | No   | No     | Yes               | Yes      |

- "\*" a check is ran to only add the aliases if the command is valid for your system... meaning say the "yarn" aliases SHOULDN'T be added if you do not have/use "yarn"
- "\*\*" - Agnoster from OMZ repo or custom theme

## Screenshots

| Before/Vanilla zsh                                   | After running (Complete option) Scripts               |
| ---------------------------------------------------- | ----------------------------------------------------- |
| ![Before/Vanilla zsh](assets/screenshots/before.jpg) | ![After running script](assets/screenshots/after.jpg) |

## Credits

ALL CREDIT for the downloaded plugins go to their developer(s).

## Plugins

### [Oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)

- **Colorize**:
  - Source: <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize>
  - allows you to type `ccat <file>` to show a file in cat but with syntax coloring
- **FZF**

  - Source: <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/fzf>
  - Fuzzy Finder in terminal
  - Keybindings:
    - `Ctrl+T` to "start"
    - `CTRL-R`: ??
    - `ALT-C`: ??

- **sudo**:

  - Source: <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo>
  - lets you press ESC twice and it will add "sudo" to the start of lines you may have forgotten to add it to

- Disabled Plugin
  - DirHistory:
    - Source: <https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/dirhistory>
    - Allows you to use Alt+Arrow Keys to navigate between say the PWD and Parent or Child directories
    - *issue*: I find this doesn't work in the terminal "inside of" vscode
    - MY COMMENT: There is nothing wrong with this plugin ... I have chosen to disable it since with autocomplete using the same keybindings, this doesn't work if both plugins are added. I am leaving this here since some users who dont want to use auto-complete MAY find this plugin useful.

### [zsh-users](https://github.com/zsh-users)

- Enabled by Default
  - zsh-autosuggestion: <https://github.com/zsh-users/zsh-autosuggestions>
  - zsh-syntax-highlighting: <https://github.com/zsh-users/zsh-syntax-highlighting>
- Not Enabled by Default
  - zsh-completions: <https://github.com/zsh-users/zsh-completions>
  - zsh-history-substring-search: <https://github.com/zsh-users/zsh-history-substring-search>

### [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete)

- When typing a list of options related to what is typed, is displayed under the current prompt.
  - I THINK this is the plugin that caused me to disable Zshuser's Completion and substring search plugins, listed above.

### [colored-man-pages](https://github.com/ael-code/zsh-colored-man-pages)

- Colorizes man pages for easier viewing

## Theming

- The only theme code I have now is based on (the overall look, maybe not default color scheme) [BobTheFish](https://github.com/oh-my-fish/theme-bobthefish) used in the [Fish Shell](https://fishshell.com/)/[Fish on Github](https://github.com/fish-shell/fish-shell) from [OhMyFish](https://github.com/oh-my-fish/oh-my-fish)

- I have ideas to allow users to use different colors for different parts of the theme and also possible have it where i can add diffferent themes and most of the code stays the same... that is for down the line though

## Projects

Projects I either use parts of in this script/find interesting and may use/are just similiar (setting up zsh) somehow

- [fancy-git](https://github.com/diogocavilha/fancy-git)
- [OhMyZsh](https://github.com/ohmyzsh/ohmyzsh)
- [zsh-users](https://github.com/zsh-users)
- [zsh-git-prompt](https://github.com/zsh-git-prompt/zsh-git-prompt)
- [zsh-autocomplete](https://github.com/marlonrichert/zsh-autocomplete)
- [colored-man-pages](https://github.com/ael-code/zsh-colored-man-pages)
