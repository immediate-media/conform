install_xcode() {
    if [ -x "$(command -v xcode-select)" ]; then
        print_success "Xcode already installed"
    else
        step "Installing Xcode..."
        xcode-select --install
        print_success "Xcode installed"
    fi

    if [ ! -d "$HOME/.bin/" ]; then
        mkdir "$HOME/.bin"
    fi
}

install_homebrew() {
    if ! [ -x "$(command -v brew)" ]; then
        step "Installing Homebrew..."
        curl --fail --retry 3 --retry-delay 1 -sS 'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
        export PATH="/usr/local/bin:$PATH"
        print_success "Homebrew installed"
    else
        print_success "Homebrew already installed"
    fi

    if brew list | grep -Fq brew-cask; then
        step "Uninstalling old Homebrew-Cask..."
        brew uninstall --force brew-cask
        print_success "Homebrew-Cask uninstalled"
    fi
}

install_nvm() {
    if [ -x nvm ]; then
        step "Installing NVM..."
        curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
        print_success "NVM installed"
    else
        print_success "NVM already installed"
    fi
}

install_node() {
    . ~/.nvm/nvm.sh

    nvm install $NODE_VERSION >/dev/null 2>&1
    nvm use $NODE_VERSION >/dev/null
    nvm alias default $NODE_VERSION >/dev/null
    nodev=$(node -v)
    print_success "Using Node $nodev"
}

install_brews() {
    local n_brews=${#BREWS[@]}
    local list=$(brew list)

    print_install "Updating Homebrew"
    brew update >/dev/null

    print_install "Cleaning brews"
    brew cleanup &>/dev/null

    print_install "Installing $n_brews brews"

    for brew in ${BREWS[@]}; do
        if echo "$list" | grep -q "$brew"; then
            print_success "$brew already installed"
        else
            brew install $brew
            print_exit_feedback "${brew} installed" "${brew} install failed"
        fi
    done
}

install_casks() {
    local n_casks=${#CASKS[@]}
    local list=$(brew list --cask)
    local outdated=$(brew outdated --cask)

    print_install "Installing $n_casks casks"

    for cask in ${CASKS[@]}; do
        if echo "$outdated" | grep -q "$cask"; then
            brew upgrade --cask "$cask"
            print_exit_feedback "${cask} upgraded" "${cask} upgrade failed"
        elif echo "$list" | grep -q "$cask"; then
            print_success "$cask already installed"
        else
            brew install --cask "$cask" --appdir=/Applications
            print_exit_feedback "${cask} installed" "${cask} install failed"
        fi
    done
}

install_node_packages() {
    local n_packages=${#NODE_PACKAGES[@]}
    local list=$(yarn global list)

    print_install "Cleaning yarn cache"
    yarn cache clean $NODE_PACKAGES &>/dev/null

    print_install "Installing $n_packages packages"

    for package in ${NODE_PACKAGES[@]}; do
        if echo "$list" | grep -q "\"${package}@"; then
            print_success "$package already installed"
        else
            yarn global add $package &>/dev/null
            print_exit_feedback "${package} installed" "${package} install failed"
        fi
    done
}
