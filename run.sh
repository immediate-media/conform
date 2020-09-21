
#!/usr/bin/env bash

NODE_VERSION=10

BREWS=(
    autojump
    awscli
    bash
    composer
    coreutils
    docker-compose
    gh
    grep
    jq
    moreutils
    php
    python
    wget
    yarn
)

NODE_PACKAGES=(
    newman
    webpack
    webpack-cli
    yalc
)

CASKS=(
    docker
    firefox
    google-chrome
    iterm2
    phpstorm
    slack
    visual-studio-code
)

# Let the user know if the script fails
trap 'ret=$?; test $ret -ne 0 && printf "\n\e[31mFatal error, you have not conformed.\033[0m\n" >&2; exit $ret' EXIT

set -e

# Get full directory name of this script
cwd="$(cd "$(dirname "$0")" && pwd)"

source "$cwd/bin/print.sh"
source "$cwd/bin/checks.sh"
source "$cwd/bin/install.sh"
source "$cwd/bin/configure.sh"

printf "

         ___ ___  _  _ ___ ___  ___ __  __
        / __/ _ \| \| | __/ _ \| _ \  \/  |
       | (_| (_) | .  | _| (_) |   / |\/| |
        \___\___/|_|\_|_| \___/|_|_\_|  |_|

-----------------------------------------------------
╭───────────────────────────────────────────────────╮
│  You are about to conform.                        │
│───────────────────────────────────────────────────│
│  Safe to run multiple times on the same machine.  │
│  It ${green}installs${nc}, ${cyan}upgrades${nc}, or ${yellow}skips${nc} packages based   │
│  on what is already installed on the machine.     │
╰───────────────────────────────────────────────────╯
"

chapter "Performing initial checks..."
check_internet_connection
check_ssh_key

chapter "Installing core dependencies..."
install_xcode
install_homebrew
install_nvm
install_node

chapter "Installing brews..."
install_brews
check_brews

chapter "Installing casks..."
install_casks
check_casks

chapter "Installing node packages..."
install_node_packages

chapter "Configuring..."
configure_git
