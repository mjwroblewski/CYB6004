#!/bin/bash

# Hashes the entered password and compares it to secret.txt
# Displays an "Access Granted" or "Access Denied" message

# Michael - 2022/01/24

read -sp "Please enter your secret password: " secretPassword

    echo $secretPassword | sha256sum > secretCheck

        # Hashes the entered password

if diff -q "secretCheck" "Passwords/secret.txt" >/dev/null; then

    # Checks whether the entered password hash is different to the secret password hash

        echo "Access Granted"

            # If the passwords match

    exit 0

else

    echo "Access Denied"

        # If the passwords differ

    exit 1

fi

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 2: Creating user interaction scripts
        # 2.4 Write if statements to control program flow