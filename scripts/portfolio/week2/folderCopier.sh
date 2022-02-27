#!/bin/bash

# Created by Michael Wroblewski
# Date created - 2022/01/24
# Date last modified - 2022/02/27

# Demonstrates use of the "IF" function and "cp" command

# Creates, renames and saves a copy of an existing folder usung an IF statement
# Displays an error if the folder name entered doesn't exist
# The script fails if the copied and destination folder names are identical
# The script fails if values including \/:*?"<>| are used in destination name

read -p "Type the name of the folder you would like to copy: " folderName

# Check if there is a directory with that name

if [ -d "$folderName" ]; then

    read -p "Type the name of the destination folder: " newFolderName

    # Save a copy of the folder using the entered name

    cp -r "$folderName" "$newFolderName"

else

    # If the folder doesn't exist, print an error message

    echo "I couldn't find that folder"

fi

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 2: Creating user interaction scripts
        # 2.3 Understand and execute scripts that require decision-making