
#!/usr/bin/env bash

NODE_VERSION=10

BREWS=(
    autojump
    awscli
    bash
    coreutils
    docker-compose
    gh
    grep
    jq
    moreutils
    php
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
    visual-studio-code
)

# Let the user know if the script fails
trap 'ret=$?; test $ret -ne 0 && printf "\n\e[31mFatal error, you have not been reformed.\033[0m\n" >&2; exit $ret' EXIT

set -e

# Get full directory name of this script
cwd="$(cd "$(dirname "$0")" && pwd)"

source "$cwd/bin/pretty_print.sh"
source "$cwd/bin/checks.sh"
source "$cwd/bin/install.sh"
source "$cwd/bin/configure.sh"

printf "
            ___                   _   _
    ___ ___|  _|___ ___ _____ ___| |_|_|___ ___
   |  _| -_|  _| . |  _|     | .'|  _| | . |   |
   |_| |___|_| |___|_| |_|_|_|__,|_| |_|___|_|_|
----------------------------------------------------
╭───────────────────────────────────────────────────╮
│  You are about to be ${bold}reformed${normal}.                    │
│───────────────────────────────────────────────────│
│  Safe to run multiple times on the same machine.  │
│  It ${green}installs${nc}, ${cyan}upgrades${nc}, or ${yellow}skips${nc} packages based   │
│  on what is already installed on the machine.     │
╰───────────────────────────────────────────────────╯
"

chapter "Performing checks..."
check_internet_connection
check_ssh_key

chapter "Installing core dependencies..."
install_xcode
install_homebrew
install_nvm
install_node

chapter "Installing brews..."
install_brews

chapter "Installing node packages..."
install_node_packages

chapter "Configuring..."
configure_git
