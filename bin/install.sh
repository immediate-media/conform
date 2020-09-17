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
    version=$1

    . ~/.nvm/nvm.sh

    nvm install $version >/dev/null 2>&1
    nvm use $version >/dev/null
    nvm alias default $version >/dev/null
    nodev=$(node -v)
    print_success "Using Node $nodev"
}

install_brews() {
    brews=$1

    print_install "Updating brews"
    brew update >/dev/null

    print_install "Cleaning brews"
    brew cleanup &>/dev/null

    for brew in ${brews[@]}; do
        if test ! $(brew list | grep $brew); then
            print_install "Installing $brew"
            brew install $brew >/dev/null
            exit_code=$?
            if [ $exit_code -eq "1" ]; then
                print_error "${brew} install failed"
            else
                print_success "${brew} installed"
            fi
        else
            print_success "$brew already installed"
        fi
    done
}
