#!/bin/bash

# Runs passwordCheck and inputs the exit codes into an IF statement
# If the entered password is incorrect, the script terminates.
# If the password is correct a menu is shown (READ statement)
# Selecting a menu option triggers a CASE statement. Each option triggers a different script.

# Michael - 2022/01/27

./passwordCheck.sh

# If password is incorrect
if [ $? -ne 0 ]; then

echo "    Goodbye"
exit 0

else

# If password is correct
read -p "
    1. Create a folder: 
    2. Copy a folder: 
    3. Set a password: 
    4. Quit: " CHOICE
   
    echo "
    You selected $CHOICE
     "
     # READ statement choices trigger different CASE statement script
    case "$CHOICE" in

       # Runs folderMaker
       1)
          "./folderMaker.sh" ;
            echo "    Thank you, good bye"
            exit 0
            ;;

       # Runs folderCopier
       2)
            "./folderCopier.sh" ;
            echo "    Thank you, good bye"
            exit 0
            ;;

       # Runs setPassword
       3)
            "./setPassword.sh" ;
            echo "    Thank you, good bye"
            exit 0
            ;;

       # Option to quit the script
       4)   
            echo "    Thank you, good bye"
            exit 0 
            ;;

       # Invalid menu option entered
       *)
            echo "    $CHOICE is not a valid response" ;
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