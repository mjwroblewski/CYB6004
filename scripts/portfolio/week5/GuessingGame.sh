#!/bin/bash

# Created by Michael Wroblewski
# Date created - 2022/02/21
# Date last modified - 2022/02/28


# NOTE: Updated in Week 5
# Demonstrates the use of regex to substitute text

# The script loops and displays an error message until the user enters the correct value

printError() {

    echo -e "\033[31mERROR:\033[0m $1" 
}

GuessNumber() {

    read -p "$1: "
    
    while (( $REPLY < $2 )); do

    printError "Too low, guess again!"

        read -p "$1: "

        while (( $REPLY > $2 )); do

        printError "Too high, guess again!"

            read -p "$1: "

            while (( $REPLY == $2 )); do

            echo "Right!"

            break

            done
            
        done
        
    done
    }

GuessNumber "Please guess a number between 1 and 100" 42

# References
   # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 4 - Functions and editing code
        # 4.2 Understand and execute scripts that use multiple functions
        # 4.3 Putting it together
 
