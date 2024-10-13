#!/bin/bash

if [ $# -ne 1 ]; then
    echo -e "\e[31m[ERROR]: \e[37mYou must pass a file or a folder.\nUsage: $0 <file/folder>"
    exit 1
fi

INPUT="$1"

if [ ! -e "$INPUT" ]; then
    echo -e "\e[31m[ERROR]: \e[37m$INPUT does not exist."
    exit 1
fi

OUTPUT="${INPUT%/}.tar.xz"

tar -cJf "$OUTPUT" "$INPUT"

echo -e "\e[34m[PROGRAM]: \e[37mInput:  $INPUT"
echo -e "\e[34m[PROGRAM]: \e[37mOutput: $OUTPUT"
echo -e "\n\e[34m[PROGRAM]: \e[37mCompression in progress...\n"

if [ $? -eq 0 ]; then
    echo -e "\e[34m[PROGRAM]: \e[37mFile/Folder has been compressed!"
    echo -e "\e[34m[PROGRAM]: \e[37mYour File/Folder is located at $OUTPUT"
else
    echo -e "\e[31m[ERROR]: \e[37mSomething went wrong with $INPUT compress!"
    exit 1
fi
