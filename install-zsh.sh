#!/bin/bash

#Mengecek apakah zsh sudah terinstal
if ! command -v zsh &> /dev/null
then
    echo "Zsh tidak ditemukan, menginstal Zsh..."
    # Untuk Debian/Ubuntu-based images
    if [ -f /etc/debian_version ]; then
        apt-get update
        apt-get install -y zsh curl git wget
    # Untuk Alpine-based images
    elif [ -f /etc/alpine-release ]; then
        apk update
        apk add zsh curl git wget
    else
        echo "Distribusi sistem tidak dikenali, harap instal zsh secara manual."
        exit 1
    fi
fi

# Mengecek apakah oh-my-zsh sudah terinstal
rm -rf /home/devilbox/.oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh-My-Zsh belum terinstal, menginstal Oh-My-Zsh..."
    # Instalasi Oh-My-Zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "Menginstall theme spaceship..."
    git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
    sed -i -r 's/^ZSH_THEME=.*$/ZSH_THEME="spaceship"/' ~/.zshrc


    echo "Menginstall my plugin with zsh-autosuggestions and zsh-syntax-highlighting"
    sh -c "git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions"
    sh -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    sed -i 's~plugins=(~plugins=(git docker docker-compose python sudo ubuntu colorize nmap zsh-autosuggestions zsh-syntax-highlighting ~g' ~/.zshrc && \
    sed -i '1iZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20' ~/.zshrc && \
    sed -i '1iZSH_AUTOSUGGEST_STRATEGY=(history completion)' ~/.zshrc && \
    sed -i '1iZSH_AUTOSUGGEST_USE_ASYNC=1' ~/.zshrc && \
    sed -i '1iTERM=xterm-256color' ~/.zshrc
    echo 'export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"' >> ~/.zshrc
    echo "AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=250'" >> ~/.zshrc

else
    echo "Oh-My-Zsh sudah terinstal!"
fi
echo "Instalasi Oh-My-Zsh selesai!"

