#!/bin/bash

# Created by Michael Wroblewski
# Date created - 2022/02/17
# Date last modified - 2022/02/28

# Demonstrates use of functions and nested "while loops"

# The script asks the user to guess a number between two parameters
# An error message is displayed when a guess is incorrect
# The script loops continue until the correct number is guessed

# When called, the "printError" function prints an error message in red text

printError() {

    echo -e "\033[31mERROR:\033[0m $1" 
}

# The "GuessNumber" function asks for a value between the 2nd and 3rd arguments
# "While loops" call the "printError" function while guesses are incorrect
# The loop breaks and script terminates when the correct values is entered

GuessNumber() {

    read -p "$1: "
    
    while (( $REPLY < $2 )); do

    printError "Too low, guess again!"

        read -p "$1: "

        while (( $REPLY > $2 )); do

        printError "Too high, guess again!"

            read -p "$1: "

            while (( $REPLY == $2 )); do

            echo "Correct!"

            break

            done
            
        done
        
    done
    }


###############
# Main script #
###############

GuessNumber "Please guess a number between 1 and 100" 42


# References
   # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 4 - Functions and editing code
        # 4.2 Understand and execute scripts that use multiple functions
        # 4.3 Putting it together
 
