#!/bin/bash 

# Created by Michael Wroblewski
# Date created - 2022/01/24
# Date last modified - 2022/02/28

# Demonstrates the use of script debugging
# Demsonstrates the use of nested CASE statements

secret='shhh'

read -p "What's the secret? " REPLY

# Check if the input value and "secret" variable match
# If the values match, assign the "true" condition
# If the values don't match, assign the "false" condition
      
if [ "$secret" = "$REPLY" ]; then 
      
       echo "You got it right!" 
      
       correct=true  
      
else
       echo "You got it wrong :(" 
      
       correct=false 
      
fi 

# Check if the input value and "code" variable match
# If the values match, display the menu
# If the values don't match, assign the "false" condition

code='abc123'

read -s -p "What's the secret code? " REPLY2

if [ "$code" = "$REPLY2" ]; then

      echo "You got it right again!"
    
      echo "You have unlocked the secret menu!"
      
      echo "Pick a prize: "
      
      read -p "
       1. Prize 1
       2. Prize 2
       3. Prize 3
       " CHOICE
       echo "You selected $CHOICE!"

else

       correct=false

fi

# If one or both of the answers are incorrect, terminate script
# If both answers are correct, display the menu selection
# If an invalid menu selection is made, display another response

case $correct in 

 false) 

       echo "Go Away!"
       exit 1
       ;;

true) 

       case $CHOICE in
              1) 
                     echo "Insert generic joke #1"
                     ;;
              2) 
                     echo "Insert generic joke #2"
                     ;;
              3) 
                     echo "Insert generic joke #3"
                     ;;     
              *) 
                     echo "You get the booby prize!"
                     ;;
       esac
       ;;
esac

#  References
#   CYB6004 - Scripting languages
#       Week 1: Introduction to Scripting and the Linux environment in a cybersecurity context
#       1.4 Write and execute simple shell scripts