#!bin/bash

# install apps

function brew_install_or_update() {
    if brew list $1 &>/dev/null; then
        brew upgrade $1 && echo "$1 is upgraded"
    else
        brew install $1 && echo "$1 is installed"
    fi
}

brew_install_or_update tree
brew_install_or_update jq
brew_install_or_update gh
brew tap SDKMAN/tap
brew_install_or_update SDKMAN-cli
brew_install_or_update orbstack

echo '++++++++++++++++++++++++++++++'
echo '++++++++++++++++++++++++++++++'
echo 'Apps installed!'