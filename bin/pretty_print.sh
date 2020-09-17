###############################################################################
# Variables
###############################################################################

white='\e[1;37m'
black='\e[0;30m'
blue='\e[0;34m'
green='\e[0;32m'
cyan='\e[0;36m'
red='\e[0;31m'
purple='\e[0;35m'
yellow='\e[1;33m'
grey='\e[0;30m'
nc='\e[0m' # No Color

dot="\033[31m▸ $nc"
dim="\033[2m"
bold=$(tput bold)
normal=$(tput sgr0)
underline="\e[37;4m"

chapter_count=1

###############################################################################
# Print Functions
###############################################################################

print_question() {
    printf "${cyan}  [?] $1 ${nc}\n"
}

print_success() {
    printf "${green}  [✓] $1 ${nc}\n"
}

print_warning() {
    printf "${yellow}  [!] $1 ${nc}\n"
}

print_error() {
    printf "${red}  [𝘅] $1 $2 ${nc}\n"
}

print_install() {
    printf "  [↓] $1\n"
}

###############################################################################
# Prompts
###############################################################################

ask() {
    # https://djm.me/ask
    local prompt default reply

    while true; do

        if [ "${2:-}" = "Y" ]; then
            prompt="Y/n"
            default=Y
        elif [ "${2:-}" = "N" ]; then
            prompt="y/N"
            default=N
        else
            prompt="y/n"
            default=
        fi

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "  [?] $1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
        Y* | y*) return 0 ;;
        N* | n*) return 1 ;;
        esac

    done
}

###############################################################################
# Text Formatting
###############################################################################

chapter() {
    local fmt="$1"
    shift
    printf "\n✦  ${bold}$((chapter_count++)). $fmt${normal}\n└───────────────────────────────────────────────────○\n" "$@"
}

title() {
    printf "\n$1:\n"
}

inform() {
    local fmt="$1"
    shift
    printf "   ✦  $fmt\n" "$@"
}

step() {
    printf "\n   ${dot}${underline}$@${nc}\n"
}
