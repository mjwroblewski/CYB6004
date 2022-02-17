#!/bin/bash

# The script loops and displays an error message until the user enters the correct value.
# Michael Wroblewski - 2022/02/17

printError()

{
    echo -e "\033[31mERROR:\033[0m $1" 
}

GuessNumber()

{
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

GuessNumber "Please guess a number between 1 and 100" 42

# References
   # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 4 - Functions and editing code
        # 4.2 Understand and execute scripts that use multiple functions
        # 4.3 Putting it together
 
