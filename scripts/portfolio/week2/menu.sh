#!/bin/bash

# Created by Michael Wroblewski
# Date created - 2022/01/27
# Date last modified - 2022/02/27

# Demonstrates use of exit codes as input values to control program flow
# Demonstrates use of "IF" and "CASE statements

# Script executes passwordCheck and inputs the exit codes into an IF statement
# If the entered password is incorrect, the script terminates.
# If the password is correct a menu is shown
# Selecting a menu option triggers a CASE statement
# Each option triggers a different script

# Execute script "passwordCheck.sh"

./passwordCheck.sh

# If exit value is not 0 the script terminates

if [ $? -ne 0 ]; then

echo "Goodbye"
exit 0

else

# If exit value is 0 the menu is displayed

read -p "
    1. Create a folder: 
    2. Copy a folder: 
    3. Set a password: 
    4. Quit: " CHOICE
   
    echo "
    You selected $CHOICE
     "
     # Entered value triggers a different CASE statement script

    case "$CHOICE" in

       # Runs "folderMaker.sh" script

       1)
          "./folderMaker.sh" ;
            echo "Thank you, good bye"
            exit 0
            ;;

       # Runs "folderCopier.sh" script

       2)
            "./folderCopier.sh" ;
            echo "Thank you, good bye"
            exit 0
            ;;

       # Runs "setPassword.sh" script

       3)
            "./setPassword.sh" ;
            echo "Thank you, good bye"
            exit 0
            ;;

       # Option to quit the script

       4)   
            echo "Thank you, good bye"
            exit 0 
            ;;

       # Invalid menu option entered
       *)
            echo "$CHOICE is not a valid response" ;
            exit 0
            ;;

    esac

exit 0

fi

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 2: Creating user interaction scripts
        # 2.5 Write case statements to control program flow

     # Putorius (2020) "How to Create a Multiple Choice Menu in Bash Scripts"
          # https://www.putorius.net/create-multiple-choice-menu-bash.html

    # Unix $ Linux (2018) "bash - How can I re-display selection menu after a selection is chosen and performed"
          # https://devdojo.com/bobbyiliev/how-to-create-an-interactive-menu-in-bash
     
     # 4Unix $ Linux (2019) "How does one extract a command's exit status into a variable?"
          # https://unix.stackexchange.com/questions/294371/how-does-one-extract-a-commands-exit-status-into-a-variable