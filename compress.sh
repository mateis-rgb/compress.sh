#!/bin/bash

if [ $# -ne 1 ]; then
    echo -e "\e[31m[ERREUR]: \e[37mVous devez passer un fichier ou un dossier.\nUsage: $0 <fichier/dossier>"
    exit 1
fi

INPUT="$1"

if [ ! -e "$INPUT" ]; then
    echo -e "\e[31m[ERREUR]: \e[37m$INPUT n'existe pas."
    exit 1
fi

OUTPUT="${INPUT%/}.tar.xz"

tar -cJf "$OUTPUT" "$INPUT"

echo -e "\e[34m[PROGRAMME]: \e[37mEntrée :  $INPUT"
echo -e "\e[34m[PROGRAMME]: \e[37mSortie : $OUTPUT"
echo -e "\n\e[34m[PROGRAMME]: \e[37mCompression en cours...\n"

if [ $? -eq 0 ]; then
    echo -e "\e[34m[PROGRAMME]: \e[37mLe fichier ou dossier a été compressé !"
    echo -e "\e[34m[PROGRAMME]: \e[37mVotre fichier ou dossier est situé à $OUTPUT"
else
    echo -e "\e[31m[ERREUR]: \e[37mUne erreur est survenue lors de la compression de $INPUT !"
    exit 1
fi

