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

    echo -e "\vDo you want the Slim, Medium or Complete setup?"
    read -p "(S/M/C)" setupTypeSelection

    case $setupTypeSelection in

        [cC])   clear
                ohmyzshPlugins && zshUserPlugins && userPrompt
                setupPromptTheme
                metaAliasAndOthers
                ;;

        [mM])   clear
                setupPromptTheme
                metaAliasAndOthers
                ;;

        [sS])   clear
                metaAliasAndOthers
                ;;

        [tT]) ohmyzshPlugins_havingIssues ;;
    esac
}

selectSetupType