#!/bin/bash
clear

# import needed functions 
source components/general.sh
source components/plugins.sh
source components/theming.sh
source components/aliases.sh


#################################################################################

intialTasks
clearZSHRC


function selectSetupType() {

    echo -e "\vDo you want the Slim setup or the Complete setup?"
    read -p "(S/C)" setupTypeSelection 

    case $setupTypeSelection in 

        [sS])   clear
                createHistoryLocation
                setupPromptTheme
                echo "Setting up Aliases" && userPrompt && setupBasicAliases && setupGitAliases ;;
        
        
        [cC])   clear
                ohmyzshPlugins
                zshUserPlugins && userPrompt
                createHistoryLocation
                setupPromptTheme
                
                echo  "Setting up Aliases" && userPrompt && setupBasicAliases ;; 

    esac 

}

selectSetupType
