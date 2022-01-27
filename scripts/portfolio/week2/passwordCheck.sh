#!/bin/bash

# Hashes the entered password and compares it to secret.txt
# Displays an "Access Granted" or "Access Denied" message

# Michael - 2022/01/26

# Read the password
read -sp "    Please enter your secret password: " var_passCheck

    # Hash the entered password
    var_checkHash=$(echo "$var_passCheck" | sha256sum)

    # Read password secret.txt into a variable
    var_sPass="Passwords/secret.txt"
    var_sHash=$(cat "$var_sPass")

# Check whether the passwords match
if [ "$var_sHash" = "$var_checkHash" ]; then
 
    # If the passwords match
    echo " Access Granted"

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
    