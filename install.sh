#!/bin/bash

# Créer le répertoire ~/.bin/compress s'il n'existe pas
INSTALL_DIR="$HOME/.bin/compress"
mkdir -p "$INSTALL_DIR"

# Vérifier si le script compress.sh existe
if [ ! -f "compress.sh" ]; then
    echo -e "\e[31m[ERROR]: \e[37mLe fichier compress.sh n'existe pas dans le répertoire courant."
    exit 1
fi

# Déplacer les fichiers dans le répertoire d'installation
mv compress.sh install.sh uninstall.sh "$INSTALL_DIR"

# Rendre les fichiers exécutables
chmod +x "$INSTALL_DIR/compress.sh" "$INSTALL_DIR/install.sh" "$INSTALL_DIR/uninstall.sh"

# Déterminer quel shell est utilisé
if [ "$SHELL" == "/bin/bash" ]; then
    RC_FILE="$HOME/.bashrc"
elif [ "$SHELL" == "/bin/zsh" ]; then
    RC_FILE="$HOME/.zshrc"
elif [ "$SHELL" == "/bin/sh" ]; then
    RC_FILE="$HOME/.shrc"
else
    echo -e "\e[31m[ERROR]: \e[37mShell non supporté. Utilisez bash ou zsh."
    exit 1
fi

# Vérifier si la ligne est déjà présente
if grep -q "source $INSTALL_DIR/compress.sh" "$RC_FILE"; then
    echo -e "\e[34m[PROGRAM]: \e[37mLa ligne est déjà présente dans $RC_FILE."
else
    # Ajouter la ligne pour exécuter compress.sh
    echo "alias compress=\"$INSTALL_DIR/compress.sh\"" >> "$RC_FILE"
    echo -e "\e[34m[PROGRAM]: \e[37mLe script compress.sh a été ajouté à $RC_FILE."
fi

echo -e "\e[34m[PROGRAM]: \e[37mInstallation terminée. Veuillez redémarrer votre shell ou exécuter 'source $RC_FILE' pour appliquer les changements."
