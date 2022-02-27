
#!/bin/bash 

# Created by Michael Wroblewski
# Date created - 2022/02/09
# Date last modified - 2022/02/28

# Demonstrates use of functions and "while loops"

# The script asks the user to enter a number between two parameters
# The script loops continue until the value is within the function parameters
      
# When called, the "printError" function prints an error message in red text
      
printError() {

    echo -e "\033[31mERROR:\033[0m $1" 

} 
      
# The "getNumber" function asks for a value between the 2nd and 3rd arguments
# A while loop continues to call the "printError" function while guesses are incorrect
      
getNumber() { 
    
    read -p "$1: " 
      
    while (( $REPLY < $2 || $REPLY> $3 )); do 
      
    printError "Input must be between $2 and $3" 
      
    read -p "$1: " 
      
    done 
      
} 

###############
# Main script #
###############

echo "this is the start of the script" 
      
getNumber "please type a number between 1 and 10" 1 10 
      
echo "Thank you!" 
      
getNumber "please type a number between 50 and 100" 50 100 
      
echo "Thank you!"

exit 0

# References
   # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 4 - Functions and editing code
        # 4.2 Understand and execute scripts that use multiple functions