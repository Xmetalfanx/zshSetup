#!/bin/bash
#clear

# import needed functions

source components/plugins.sh
source components/aliases.sh
source components/general.sh
source components/themeUtils.sh

#################################################################################

intialTasks
clearZSHRC

function selectSetupType() {

        echo -e "Brief Description
        ZapPluginManager -
        Complete - Adds OhmyZsh and zsh-user plugins manually, theming, tweaks and aliases
        NonTheme Complete (NT) - SAME as complete, expect NO THEMING
        Medium - Adds theming, tweaks and aliases
        Slim - Adds tweaks and aliases

\vDo you want the Slim, Medium or Complete setup or do you want to install the Zap Plugin Manager?
        "
        read -rp "(z/s/m/nt/c)" setupTypeSelection

    case $setupTypeSelection in

        [cC])   clear
                ohmyzshPlugins && zshUserPlugins && zshPluginAutoComplete && coloredManPages && userPrompt
                themeChooser
                metaAliasAndOthers
                ;;

        "nt"|"NT")  clear
                ohmyzshPlugins && zshUserPlugins && zshPluginAutoComplete && coloredManPages && userPrompt
                metaAliasAndOthers
                ;;

        [mM])   clear
                themeChooser
                metaAliasAndOthers
                ;;

        [sS])   clear
                metaAliasAndOthers
                ;;

        [tT])  clear
                ohmyzshPlugins
                #zshUserPlugins && zshPluginAutoComplete && coloredManPages && userPrompt
                #themeChooser
                #metaAliasAndOthers
                ;;

        [zZ]) installZapPluginManager ;;

        *) echo -e "invalid selection" && sleep 1 && selectSetupType ;;

    esac

    # my old theming: setupPromptTheme
}

selectSetupType