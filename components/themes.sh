#!/bin/bash

# note: having "" like a blank string especially for BG colors means no BG color

function xmetalTheme1() {

    NAMEBGCOLOR=${DEFAULTBGCOLOR}
    NAMEFGCOLOR=${whiteFG}

    DATEBGCOLOR=""
    DATEFGCOLOR=${whiteFG}

    FULLPATHBGCOLOR=${DEFAULTBGCOLOR}
    FULLPATHFGCOLOR=${whiteFG}

    PWDBGCOLOR=${DEFAULTBGCOLOR}
    PWDFGCOLOR=${whiteFG}

    GITBRANCHBGCOLOR=""
    GITBRANCHFGCOLOR=${neonGreenFG}

    generateXmetalTheme1
}


function xmetalTheme2() {   
   
    NAMEBGCOLOR=${DEFAULTBGCOLOR}
    NAMEFGCOLOR=${whiteFG}
    
    DATEBGCOLOR=${whiteBG}
    DATEFGCOLOR=""

    FULLPATHBGCOLOR=""
    FULLPATHFGCOLOR=${whiteFG}

    PWDBGCOLOR=${DEFAULTBGCOLOR}
    PWDFGCOLOR=${whiteFG}

    GITBRANCHBGCOLOR=${DEFAULTBGCOLOR}
    GITBRANCHFGCOLOR=${blueFG}

   generateXmetalTheme2
}
