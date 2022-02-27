#!/bin/bash

# Created by Michael Wroblewski
# Date created - 2022/01/24
# Date last modified - 2022/02/27

# The script creates a new folder
# Demonstrates use of the "read -p" and "mkdir" commands

# "read" command pauses the script, "-p" flag prompts user to enter folder name
# "mkdir" command creates a directory of the entered name
# The script fails if user enters values including \/:*?"<>|

read -p "Type the name of the folder you would like to create: " folderName
mkdir "$folderName"
exit 0

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 2: Creating user interaction scripts
        # 2.1 Understanding and executing scripts that require interactivity