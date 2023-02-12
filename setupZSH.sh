#!/bin/bash
clear

# import needed functions
source components/plugins.sh
source components/aliases.sh
source components/general.sh
source components/theming.sh

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
                setupPromptTheme
                metaAliasAndOthers
                ;;

        "nt"|"NT")  clear
                ohmyzshPlugins && zshUserPlugins && zshPluginAutoComplete && userPrompt
                metaAliasAndOthers
                ;;

        [mM])   clear
                setupPromptTheme
                metaAliasAndOthers
                ;;

        [sS])   clear
                metaAliasAndOthers
                ;;

        *) echo -e "invalid selection" && sleep 1 && selectSetupType ;; 

    esac
}

selectSetupType