#!/bin/bash

# Déterminer quel shell est utilisé
if [ "$SHELL" == "/bin/bash" ]; then
    RC_FILE="$HOME/.bashrc"
elif [ "$SHELL" == "/bin/zsh" ]; then
    RC_FILE="$HOME/.zshrc"
elif [ "$SHELL" == "/bin/sh" ]; then
    RC_FILE="$HOME/.shrc"
else
    printf "\e[31m[ERROR]: \e[37mShell non supporté. Utilisez bash ou zsh."
    exit 1
fi

# Supprimer la ligne correspondante dans le fichier de configuration du shell
if grep -q "source $HOME/.bin/compress/compress.sh" "$RC_FILE"; then
    sed -i "\|source $HOME/.bin/compress/compress.sh|d" "$RC_FILE"
    printf "\e[34m[PROGRAM]: \e[37mLa ligne a été retirée de $RC_FILE."
else
    printf "\e[34m[PROGRAM]: \e[37mAucune ligne à retirer dans $RC_FILE."
fi

# Supprimer le répertoire d'installation
rm -rf "$HOME/.bin/compress"
printf "\e[34m[PROGRAM]: \e[37mLe répertoire ~/.bin/compress a été supprimé."
