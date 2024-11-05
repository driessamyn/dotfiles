#!bin/bash

# Hide the "last login" line when starting a new terminal session
touch $HOME/.hushlogin

# Install oh-my-zsh
if [[ -z "${ZSH}" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "oh-my-zsh already installed"
fi

function clone_or_pull() {
    if [ ! -d "$2" ]; then
        git clone $1 $2
    else
        git -C $2 pull $1
    fi
}

# # zsh-autosuggestions
clone_or_pull "https://github.com/zsh-users/zsh-autosuggestions" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
# # zsh-syntax-highlighting
clone_or_pull "https://github.com/zsh-users/zsh-syntax-highlighting" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
# # Powerlevel10k theme
clone_or_pull "https://github.com/romkatv/powerlevel10k.git" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"

# # Symlink zsh prefs
rm $HOME/.zshrc
ln -s $HOME/.dotfiles/shell/.zshrc $HOME/.zshrc

# # Symlink vim prefs
rm $HOME/.vimrc
ln -s $HOME/.dotfiles/shell/.vimrc $HOME/.vimrc

# # Symlink p10k config
rm $HOME/.p10k.zsh
ln -s $HOME/.dotfiles/shell/.p10k.zsh $HOME/.p10k.zsh

# # Install Homebrew and some packages
if ! command -v brew 2>&1 >/dev/null
then
    echo "installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    brew update
fi

function brew_install_or_update() {
    echo "Installing $1"
    if brew list $1 &>/dev/null; then
        brew upgrade $1 && echo "$1 is upgraded"
    else
        brew install $1 && echo "$1 is installed"
    fi
}

brew_install_or_update tree
brew_install_or_update jq
brew tap SDKMAN/tap
brew_install_or_update SDKMAN-cli

echo '++++++++++++++++++++++++++++++'
echo '++++++++++++++++++++++++++++++'
echo 'All done!'
