#!/bin/bash

# ammended from https://github.com/ClouddJR/dotfiles/

echo 'Bootstrapping my mac'

while true
do
    echo '-----------------'
    echo 'Choose an option:'
    echo ' 1. Bootstrap terminal'
    echo ' 2. Install apps'
    echo ' 0. Exit'
    read -p 'Answer: ' reply

    case $reply in
        1)
            sudo -v
            source $HOME/.dotfiles/terminal.sh
            ;;
        2)
            sudo -v
            source $HOME/.dotfiles/apps.sh
            ;;
        0)
            break
            ;;
        *)
            echo 'Unknown option. Try again'
            ;;
    esac
done
