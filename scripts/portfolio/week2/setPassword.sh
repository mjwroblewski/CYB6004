#!/bin/bash

# Creates a new folder and a hidden password
# Creates a file called secret.txt containing the password which has been hashed
# Moves secret.txt into folder

# Michael - 2022/01/24

read -p "Please enter folder name: " folder_var

  mkdir $folder_var

read -sp "Please enter secret password: " password_var

  echo $password_var | sha256sum > secret.txt

mv secret.txt $folder_var

exit 0

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 2: Creating user interaction scripts
        # 2.2 Writing more interactive scripts