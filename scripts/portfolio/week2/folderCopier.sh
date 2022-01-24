#!/bin/bash

# Copies an existing folder, displays an error if folder doesn't exist
# Michael - 2022/01/24

read -p "Type the name of the folder you would like to copy: " folderName

    # if the name is a valid directory

if [ -d "$folderName" ]; then

    # copy it to a new location

    read -p "Type the name of the destination folder: " newFolderName

    cp -r "$folderName" "$newFolderName"

else

    # otherwise, print an error message

    echo "I couldn't find that folder"

fi

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 2: Creating user interaction scripts
        # 2.3 Understand and execute scripts that require decision-making