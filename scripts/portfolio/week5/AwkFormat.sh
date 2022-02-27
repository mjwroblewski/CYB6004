#!/bin/bash 

# Created by Michael Wroblewski
# Date created - 2022/02/21
# Date last modified - 2022/02/28

# Demonstrates the use of "AWK"

# Extract data from input.txt using AWK
# Manipulate and present data in a table

echo "Google Server IPs:" 
      
awk 'BEGIN { 
      
FS=":"; 
      
print "________________________________"; 
      
print "| \033[34mServer Type\033[0m | \033[34mIP\033[0m             |"; 
      
} 
      
{ 
      
printf("| \033[33m%-11s\033[0m | \033[35m%-14s\033[0m |\n", $1, $2); 
      
} 
      
END { 
      
print("________________________________"); 
      
}' input.txt     

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 5: Regular expressions and text manipulation
        # 5.5 Understand and execute scripts that use AWK