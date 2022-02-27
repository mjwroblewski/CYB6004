#!/bin/bash 

# Created by Michael Wroblewski
# Date created - 2022/02/06
# Date last modified - 2022/02/28

# Demonstrates use of "C-style for loops"

# Script creates empty directories for future weeks, up to week 6


# If there aren't two arguments to the script print an error and exit 
      
if (( $#!=2 )); then 
            
    echo "Error, provide two numbers" && exit 1 
      
fi 
      
# For every number between the first argument and the last 
      
for (( i = 4; i <= 6; i++ )) 
      
do 
      
# Create a new folder for that number 
      
    echo "Creating directory number $i" 
      
    mkdir "week $i" 
      
done 

# References
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 3 - Snippets and repetition
        # 3.3 Using loops for repetition
    # https://www.golinuxcloud.com/bash-for-loop/
    # https://www.cyberciti.biz/faq/bash-for-loop/