#!/bin/bash

# Created by Michael Wroblewski
# Date created - 2022/01/26
# Date last modified - 2022/02/27

# Demonstrates use of "IF statements" to control program flow
# Demonstrates use of exit codes

# Script asks for the password used in "setPasswords.sh"
# Input text is hashed and checked against the password hash in "secret.txt"
# Displays an "Access Granted" or "Access Denied" message


# Read the password

read -sp "Please enter your secret password: " var_passCheck

    # Entered value is hashed as a variable

    var_checkHash=$(echo "$var_passCheck" | sha256sum)

    # Read password "secret.txt" into a variable

    var_sPass="Passwords/secret.txt"
    var_sHash=$(cat "$var_sPass")

# IF statement checks whether the passwords match

if [ "$var_sHash" = "$var_checkHash" ]; then
 
    # If the input hash matches the password hash

    echo "Access Granted"

    exit 0

else

# If the passwords differ

echo "Access Denied"

exit 1

fi

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 2: Creating user interaction scripts
        # 2.4 Write if statements to control program flow

    # Linuxize (2019) "How to compare strings in bash".
        #https://linuxize.com/post/how-to-compare-strings-in-bash/
    