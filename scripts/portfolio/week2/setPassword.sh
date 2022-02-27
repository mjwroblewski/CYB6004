#!/bin/bash

# Created by Michael Wroblewski
# Date created - 2022/01/24
# Date last modified - 2022/02/27

# Demonstrates use of the commands "read -sp" and "mv"
# Demonstrates use of the operators ">" and "|"
# Demonstrates use of cryptographic hashing using "sha256sum" function

# The script creates a new folder and a password
# The password is hashed and saved as "secret.txt"
# "secret.txt" is then moved into the created folder
# The script fails if user enters values including \/:*?"<>| in the folder name

read -p "Please enter folder name: " folder_var

mkdir $folder_var

# The "-s" flag stops the password from being displayed when enetered

read -sp "Please enter secret password: " password_var

# The password variable is piped "|" as an input to the "sha256sum" function
# The hashed password is outputted ">" as new file "secret.txt"

echo $password_var | sha256sum > secret.txt

# "secret.txt" is moved into the new folder

mv secret.txt $folder_var

exit 0

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 2: Creating user interaction scripts
        # 2.2 Writing more interactive scripts