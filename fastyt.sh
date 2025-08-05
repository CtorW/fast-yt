#!/bin/bash

# ---------------------------------------------------------------
#  _______ _________ _______  _______          
#(  ____ \\__   __/(  ___  )(  ____ )|\     /|
#| (    \/   ) (   | (   ) || (    )|| )   ( |
#| |         | |   | |   | || (____)|| | _ | |
#| |         | |   | |   | ||     __)| |( )| |
#| |         | |   | |   | || (\ (   | || || |
#| (____/\   | |   | (___) || ) \ \__| () () |
#(_______/   )_(   (_______)|/   \__/(_______)
#                                            
# powered by yt-dlp
# 2025
# ---------------------------------------------------------------

if tput setaf 1 >/dev/null 2>&1; then
    # Standard Colors
    Color_Off="$(tput sgr0)"
    Black="$(tput setaf 0)"
    Red="$(tput setaf 1)"
    Green="$(tput setaf 2)"
    Yellow="$(tput setaf 3)"
    Blue="$(tput setaf 4)"
    Purple="$(tput setaf 5)"
    Cyan="$(tput setaf 6)"
    White="$(tput setaf 7)"

    # Bold Colors
    BBlack="$(tput bold; tput setaf 0)"
    BRed="$(tput bold; tput setaf 1)"
    BGreen="$(tput bold; tput setaf 2)"
    BYellow="$(tput bold; tput setaf 3)"
    BBlue="$(tput bold; tput setaf 4)"
    BPurple="$(tput bold; tput setaf 5)"
    BCyan="$(tput bold; tput setaf 6)"
    BWhite="$(tput bold; tput setaf 7)"

    # Bright Bold Colors
    BIBlack="$(tput bold; tput setaf 8)"
    BIRed="$(tput bold; tput setaf 9)"
    BIGreen="$(tput bold; tput setaf 10)"
    BIYellow="$(tput bold; tput setaf 11)"
    BIBlue="$(tput bold; tput setaf 12)"
    BIPurple="$(tput bold; tput setaf 13)"
    BICyan="$(tput bold; tput setaf 14)"
    BIWhite="$(tput bold; tput setaf 15)"
else
    # Fallback to hardcoded ANSI codes if tput is not available or supported
    Color_Off="\033[0m"
    Black="\033[0;30m"
    Red="\033[0;31m"
    Green="\033[0;32m"
    Yellow="\033[0;33m"
    Blue="\033[0;34m"
    Purple="\033[0;35m"
    Cyan="\033[0;36m"
    White="\033[0;37m"

    BBlack="\033[1;30m"
    BRed="\033[1;31m"
    BGreen="\033[1;32m"
    BYellow="\033[1;33m"
    BBlue="\033[1;34m"
    BPurple="\033[1;35m"
    BCyan="\033[1;36m"
    BWhite="\033[1;37m"
    
    BIBlack="\033[1;90m"
    BIRed="\033[1;91m"
    BIGreen="\033[1;92m"
    BIYellow="\033[1;93m"
    BIBlue="\033[1;94m"
    BIPurple="\033[1;95m"
    BICyan="\033[1;96m"
    BIWhite="\033[1;97m"
fi


DOWNLOAD_DIR="fast-yt" 

show_usage() {
	echo -ne " 
${BIYellow}------------------------------------------------------

	███████╗ █████╗ ███████╗████████╗  ██╗   ██╗████████╗
	██╔════╝██╔══██╗██╔════╝╚══██╔══╝  ╚██╗ ██╔╝╚══██╔══╝
	█████╗  ███████║███████╗   ██║█████╗╚████╔╝    ██║   
	██╔══╝  ██╔══██║╚════██║   ██║╚════╝ ╚██╔╝     ██║   
	██║     ██║  ██║███████║   ██║        ██║      ██║   
	╚═╝     ╚═╝  ╚═╝╚══════╝   ╚═╝        ╚═╝      ╚═╝
	
			CtorW-helper
------------------------------------------------------${Color_Off}
	"
	echo ""
    echo "Usage: $(basename "$0") [OPTIONS] <VIDEO_URL>"
    echo ""
    echo "Options:"
    echo "  -h, --help      Show this help message."
    echo "  -o, --output    Specify a custom output directory."
    echo ""
    echo "Example:"
    echo "  $(basename "$0") \"https://www.youtube.com/watch?v=dQw4w9WgXcQ\""
    echo "  $(basename "$0") -o \"~/Movies\" \"<video_url>\""
}

while [[ "$#" -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_usage
            exit 0
            ;;
        -o|--output)
            if [ -n "$2" ]; then
                DOWNLOAD_DIR="$2"
                shift
            else
                echo "${BIRed}Error: --output requires a directory path.${Color_Off}"
                exit 1
            fi
            ;;
        *)
            VIDEO_URL="$1"
            ;;
    esac
    shift
done

# GETTING READY🔗
# AUTO yt-dlp DOWNLOADER 😲
    echo "${BICyan}'yt-dlp' is not found. Would you like to try and install it? (y/n)${Color_Off}"
    read -r answer
    if [ "$answer" != "${answer#[Yy]}" ] ;then
        echo "Attempting to install 'yt-dlp'..."
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            if command -v apt-get &> /dev/null; then
                sudo apt-get update && sudo apt-get install -y yt-dlp
            elif command -v dnf &> /dev/null; then
                sudo dnf install -y yt-dlp
            elif command -v pacman &> /dev/null; then
                sudo pacman -S --noconfirm yt-dlp
            else
	    echo -ne "
     		${BIRed}---------------------------------------------------------------------------------
		██████╗  █████╗ ███████╗██╗  ██╗    ██████╗  █████╗ ███╗   ██╗██╗ ██████╗██╗██╗██╗
		██╔══██╗██╔══██╗██╔════╝██║  ██║    ██╔══██╗██╔══██╗████╗  ██║██║██╔════╝██║██║██║
		██████╔╝███████║███████╗███████║    ██████╔╝███████║██╔██╗ ██║██║██║     ██║██║██║
		██╔══██╗██╔══██║╚════██║██╔══██║    ██╔═══╝ ██╔══██║██║╚██╗██║██║██║     ╚═╝╚═╝╚═╝
		██████╔╝██║  ██║███████║██║  ██║    ██║     ██║  ██║██║ ╚████║██║╚██████╗██╗██╗██╗
		╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝╚═╝╚═╝╚═╝
		---------------------------------------------------------------------------------${Color_Off}
    		"
                echo "${Red}Could not find a supported package manager (apt, dnf, pacman).${Color_Off}"
                echo "${Red}Please install 'yt-dlp' manually.${Color_Off}"
                exit 1
                fi
            fi
 		fi
            
# URL CHECKING SECTION
if [ -z "$VIDEO_URL" ]; then
    echo "${Red}Error: No video URL provided.${Color_Off}"
    echo ""
    show_usage
    exit 1
fi


#SCRIPT🚦

echo -ne "
${BIYellow}---------------------------------------------------------------------------------
██████╗ ██╗   ██╗███╗   ██╗███╗   ██╗██╗███╗   ██╗ ██████╗          
██╔══██╗██║   ██║████╗  ██║████╗  ██║██║████╗  ██║██╔════╝          
██████╔╝██║   ██║██╔██╗ ██║██╔██╗ ██║██║██╔██╗ ██║██║  ███╗         
██╔══██╗██║   ██║██║╚██╗██║██║╚██╗██║██║██║╚██╗██║██║   ██║         
██║  ██║╚██████╔╝██║ ╚████║██║ ╚████║██║██║ ╚████║╚██████╔╝██╗██╗██╗
╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝╚═╝╚═╝
---------------------------------------------------------------------------------${Color_Off}                                                                   
"
echo ""
echo -en "
${BIGreen}-------------------------------------
	Starting Video Download
-------------------------------------${Color_Off}
"

echo "${BIGreen}URL: $VIDEO_URL"

YT_DLP_ARGS=()

if [ -n "$DOWNLOAD_DIR" ]; then
    mkdir -p "$DOWNLOAD_DIR"
    echo "${BIYellow}Download Location: $DOWNLOAD_DIR${Color_Off}"
    YT_DLP_ARGS+=("-o" "${DOWNLOAD_DIR}/%(title)s [%(id)s].%(ext)s")
fi

echo ""
echo -ne "
${BIGreen}-------------------------------------
	Running yt-dlp...
-------------------------------------${Color_Off}
"
echo ""

yt-dlp "${YT_DLP_ARGS[@]}" "$VIDEO_URL"

if [ $? -eq 0 ]; then
    echo ""
    echo -ne "
${BIYellow}---------------------------------------------------------------------------------
██████╗ ██╗       ██████╗ ██████╗ ███╗   ███╗██████╗ ██╗     ███████╗████████╗███████╗██╗
██╔══██╗██║      ██╔════╝██╔═══██╗████╗ ████║██╔══██╗██║     ██╔════╝╚══██╔══╝██╔════╝██║
██║  ██║██║█████╗██║     ██║   ██║██╔████╔██║██████╔╝██║     █████╗     ██║   █████╗  ██║
██║  ██║██║╚════╝██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║     ██╔══╝     ██║   ██╔══╝  ╚═╝
██████╔╝███████╗ ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ███████╗███████╗   ██║   ███████╗██╗
╚═════╝ ╚══════╝  ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝     ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝
---------------------------------------------------------------------------------${Color_Off}                                                                                     
    "
    echo -ne "
${BIGreen}-------------------------------------
Download completed successfully!
-------------------------------------${Color_Off}
"
else
echo ""
echo -ne "
${BIRed}---------------------------------------------------------------------------------
██████╗  █████╗ ███████╗██╗  ██╗    ██████╗  █████╗ ███╗   ██╗██╗ ██████╗██╗██╗██╗
██╔══██╗██╔══██╗██╔════╝██║  ██║    ██╔══██╗██╔══██╗████╗  ██║██║██╔════╝██║██║██║
██████╔╝███████║███████╗███████║    ██████╔╝███████║██╔██╗ ██║██║██║     ██║██║██║
██╔══██╗██╔══██║╚════██║██╔══██║    ██╔═══╝ ██╔══██║██║╚██╗██║██║██║     ╚═╝╚═╝╚═╝
██████╔╝██║  ██║███████║██║  ██║    ██║     ██║  ██║██║ ╚████║██║╚██████╗██╗██╗██╗
╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝ ╚═════╝╚═╝╚═╝╚═╝
---------------------------------------------------------------------------------${Color_Off}
    "
echo -ne "
${BIRed}------------------------------------------------------------
Download failed. Please check the URL and your connection.
------------------------------------------------------------${Color_Off}
"
fi

# 2025 CTORW
exit 0
