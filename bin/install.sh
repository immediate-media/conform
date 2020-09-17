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

    print_install "Updating brews"
    brew update >/dev/null

    print_install "Cleaning brews"
    brew cleanup &>/dev/null

    print_install "Installing $n_brews brews"

    local list=$(brew list)

    for brew in ${BREWS[@]}; do
        if echo "$list" | grep -q "$brew"; then
            print_success "$brew already installed"
        else
            brew install $brew >/dev/null
            exit_code=$?
            if [ $exit_code -eq "1" ]; then
                print_error "${brew} install failed"
            else
                print_success "${brew} installed"
            fi
        fi
    done
}

install_node_packages() {
    local n_packages=${#NODE_PACKAGES[@]}

    print_install "Cleaning yarn cache"
    yarn cache clean $NODE_PACKAGES &>/dev/null

    print_install "Installing $n_packages packages"

    local list=$(yarn global list)

    for package in ${NODE_PACKAGES[@]}; do
        if echo "$list" | grep -q "\"${package}@"; then
            print_success "$package already installed"
        else
            yarn global add $package &>/dev/null
            exit_code=$?
            if [ $exit_code -eq "1" ]; then
                print_error "${package} install failed"
            else
                print_success "${package} installed"
            fi
        fi
    done
}
