
       #!/bin/bash 

# The script loops and displays an error message until the user enters a value within the Function parameters.
#Michael Wroblewski - 2022/02/09
 
      
#This function prints a given error 
      
printError() 
      
{ 
      
    echo -e "\033[31mERROR:\033[0m $1" 
      
} 
      
 
      
#This function will get a value between the 2nd and 3rd arguments 
      
getNumber() 
      
{ 
    
    read -p "$1: " 
      
    while (( $REPLY < $2 || $REPLY> $3 )); do 
      
    printError "Input must be between $2 and $3" 
      
    read -p "$1: " 
      
    done 
      
} 
      
 
      
echo "this is the start of the script" 
      
getNumber "please type a number between 1 and 10" 1 10 
      
echo "Thank you!" 
      
getNumber "please type a number between 50 and 100" 50 100 
      
echo "Thank you!"

# References
   # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 4 - Functions and editing code
        # 4.2 Understand and execute scripts that use multiple functions