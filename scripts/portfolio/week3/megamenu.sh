#!/bin/bash

# Runs passwordCheck and inputs the exit codes into an IF statement
# If the entered password is incorrect, the script terminates.
# If the password is correct a menu is shown (READ statement)
# Selecting a menu option triggers a CASE statement. Each option triggers a different script.

# Michael - 2022/02/08

./passwordCheck.sh

# If password is incorrect
if [ $? -ne 0 ]; then

exit 0

else

# If password is correct

echo -e "
    \033[33mSelect an option:\033[36m"

read -sp "
    1. Create a folder: 
    2. Copy a folder: 
    3. Set a password: 
    4. Calculator: 
    5. Create Week folders: 
    6. Check Filenames: 
    7. Download a file: 
    8. Quit:     
    " CHOICE

echo -e "\033[32mYou selected $CHOICE
\e[0m"

     # READ statement choices trigger different CASE statement script
    case "$CHOICE" in

       # Runs folderMaker.sh
       1)
          "./folderMaker.sh" ;
            echo "Thank you, good bye"
            exit 0
            ;;

       # Runs folderCopier.sh
       2)
            "./folderCopier.sh" ;
            echo "Thank you, good bye"
            exit 0
            ;;

       # Runs setPassword.sh
       3)
            "./setPassword.sh" ;
            echo "Thank you, good bye"
            exit 0
            ;;

       # Runs calculator.sh
       4)
            "./calculator.sh" ;
            echo "Thank you, good bye"
            exit 0
            ;;

       # Runs megafoldermaker.sh
       5)
            "./megafoldermaker.sh" ;
            echo "Thank you, good bye"
            exit 0
            ;;

       # Runs filenames.sh
       6)
            "./filenames.sh" ;
            echo "Thank you, good bye"
            exit 0
            ;;

       # Runs downloader.sh
       7)
            "./downloader.sh" ;
            echo "Thank you, good bye"
            exit 0
            ;;

       # Option to quit the script
       8)   
            echo "Thank you, good bye"
            exit 0 
            ;;

       # Invalid menu option entered
       *)
            echo "$CHOICE is not a valid response" ;
            exit 1
            ;;

    esac

exit 0

fi

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 2: Creating user interaction scripts
        # Week 3: Snippets and repetition

     # Putorius (2020) "How to Create a Multiple Choice Menu in Bash Scripts"
          # https://www.putorius.net/create-multiple-choice-menu-bash.html

    # Unix $ Linux (2018) "bash - How can I re-display selection menu after a selection is chosen and performed"
          # https://devdojo.com/bobbyiliev/how-to-create-an-interactive-menu-in-bash
     
     # 4Unix $ Linux (2019) "How does one extract a command's exit status into a variable?"
          # https://unix.stackexchange.com/questions/294371/how-does-one-extract-a-commands-exit-status-into-a-variable