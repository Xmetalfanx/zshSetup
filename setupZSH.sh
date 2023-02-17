#!/bin/bash
clear

# import needed functions

source components/plugins.sh
source components/aliases.sh
source components/general.sh
source components/theming.sh
source components/themePlugins.sh

#################################################################################

intialTasks
clearZSHRC

function selectSetupType() {

        echo -e "Brief Description
        Complete - Adds OhmyZsh and zsh-user plugins manually, theming, tweaks and aliases
        NonTheme Complete (NT) - SAME as complete, expect NO THEMING
        Medium - Adds theming, tweaks and aliases
        Slim - Adds tweaks and aliases

\vDo you want the Slim, Medium or Complete setup?
        "
        read -p "(s/m/nt/c)" setupTypeSelection

    case $setupTypeSelection in

        [cC])   clear
                ohmyzshPlugins && zshUserPlugins && zshPluginAutoComplete && userPrompt
                installAgnosterTheme
                metaAliasAndOthers
                ;;

        "nt"|"NT")  clear
                ohmyzshPlugins && zshUserPlugins && zshPluginAutoComplete && userPrompt
                metaAliasAndOthers
                ;;

        [mM])   clear
                installAgnosterTheme
                setupPromptTheme
                metaAliasAndOthers
                ;;

        [sS])   clear
                metaAliasAndOthers
                ;;

        [tT])   clear
                ohmyzshPlugins && zshUserPlugins && zshPluginAutoComplete && userPrompt
                freshThemeTry1
                metaAliasAndOthers 
                ;;
        
        *) echo -e "invalid selection" && sleep 1 && selectSetupType ;; 

    esac

    # my old theming: setupPromptTheme
}

selectSetupType