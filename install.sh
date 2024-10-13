#!/bin/bash

# Créer le répertoire ~/.bin/compress s'il n'existe pas
INSTALL_DIR="$HOME/.bin/compress"
mkdir -p "$INSTALL_DIR"

# URLs des fichiers à télécharger
COMPRESS_URL="https://raw.githubusercontent.com/mateis-rgb/compress.sh/refs/heads/main/compress.sh"
INSTALL_URL="https://raw.githubusercontent.com/mateis-rgb/compress.sh/refs/heads/main/install.sh"
UNINSTALL_URL="https://raw.githubusercontent.com/mateis-rgb/compress.sh/refs/heads/main/uninstall.sh"

# Vérifier si le script compress.sh existe, sinon le télécharger
if [ ! -f "compress.sh" ]; then
    printf "\e[33m[WARNING]: \e[37mLe fichier compress.sh n'existe pas dans le répertoire courant. Téléchargement depuis GitHub..."
    curl -o compress.sh "$COMPRESS_URL"
    if [ $? -ne 0 ]; then
        printf "\e[31m[ERROR]: \e[37mÉchec du téléchargement de compress.sh."
        exit 1
    fi
fi

# Vérifier si le script install.sh existe, sinon le télécharger
if [ ! -f "install.sh" ]; then
    printf "\e[33m[WARNING]: \e[37mLe fichier install.sh n'existe pas dans le répertoire courant. Téléchargement depuis GitHub..."
    curl -o install.sh "$INSTALL_URL"
    if [ $? -ne 0 ]; then
        printf "\e[31m[ERROR]: \e[37mÉchec du téléchargement de install.sh."
        exit 1
    fi
fi

# Vérifier si le script uninstall.sh existe, sinon le télécharger
if [ ! -f "uninstall.sh" ]; then
    printf "\e[33m[WARNING]: \e[37mLe fichier uninstall.sh n'existe pas dans le répertoire courant. Téléchargement depuis GitHub..."
    curl -o uninstall.sh "$UNINSTALL_URL"
    if [ $? -ne 0 ]; then
        printf "\e[31m[ERROR]: \e[37mÉchec du téléchargement de uninstall.sh."
        exit 1
    fi
fi

# Déplacer les fichiers dans le répertoire d'installation
mv compress.sh install.sh uninstall.sh "$INSTALL_DIR"

# Rendre les fichiers exécutables
chmod +x "$INSTALL_DIR/compress.sh" "$INSTALL_DIR/install.sh" "$INSTALL_DIR/uninstall.sh"

# Supprimer le répertoire courant s'il est vide après le déplacement des fichiers
CURRENT_DIR=$(pwd)
if [ -z "$(ls -A "$CURRENT_DIR")" ]; then
    printf "\e[34m[PROGRAM]: \e[37mLe répertoire $CURRENT_DIR est vide. Suppression..."
    rmdir "$CURRENT_DIR"
fi

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

# Vérifier si la ligne est déjà présente
if grep -q "source $INSTALL_DIR/compress.sh" "$RC_FILE"; then
    printf "\e[34m[PROGRAM]: \e[37mLa ligne est déjà présente dans $RC_FILE."
else
    # Ajouter la ligne pour exécuter compress.sh
    echo "alias compress=\"$INSTALL_DIR/compress.sh\"" >> "$RC_FILE"
    printf "\e[34m[PROGRAM]: \e[37mLe script compress.sh a été ajouté à $RC_FILE."
fi

printf "\e[34m[PROGRAM]: \e[37mInstallation terminée. Veuillez redémarrer votre shell ou exécuter 'source $RC_FILE' pour appliquer les changements."
