#!/bin/bash

if [ $# -ne 1 ]; then
    printf "\e[31m[ERREUR]: \e[37mVous devez passer un fichier ou un dossier.\nUsage: $0 <fichier/dossier>"
    exit 1
fi

INPUT="$1"

if [ ! -e "$INPUT" ]; then
    printf "\e[31m[ERREUR]: \e[37m$INPUT n'existe pas."
    exit 1
fi

OUTPUT="${INPUT%/}.tar.xz"

tar -cJf "$OUTPUT" "$INPUT"

printf "\e[34m[PROGRAMME]: \e[37mEntrée :  $INPUT"
printf "\e[34m[PROGRAMME]: \e[37mSortie : $OUTPUT"
printf "\n\e[34m[PROGRAMME]: \e[37mCompression en cours...\n"

if [ $? -eq 0 ]; then
    printf "\e[34m[PROGRAMME]: \e[37mLe fichier ou dossier a été compressé !"
    printf "\e[34m[PROGRAMME]: \e[37mVotre fichier ou dossier est situé à $OUTPUT"
else
    printf "\e[31m[ERREUR]: \e[37mUne erreur est survenue lors de la compression de $INPUT !"
    exit 1
fi

