#!/bin/bash

# Creates a new folder
# Michael - 2022/01/24

read -p "type the name of the folder you would like to create: " folderName
mkdir "$folderName"
exit 0

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 2: Creating user interaction scripts
        # 2.1 Understanding and executing scripts that require interactivity