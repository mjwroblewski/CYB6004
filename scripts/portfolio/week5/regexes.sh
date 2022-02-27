#!/bin/bash

# Created by Michael Wroblewski
# Date created - 2022/02/21
# Date last modified - 2022/02/28

# Demonstrates the use of a variety of regex commands

# Show only lines that start with 'echo'
    grep -r "^echo" 

 # Show only statements that contain an echo with a flag.   
    grep -r 'echo -.*' 
     
# Show only echo statements where the text is in double quotes and starts with an uppercase letter
    grep -r 'echo .*\"[A-Z].*\"' 
     
# Show only echo statements with text in double quotes that ends in an exclamation mark
    grep -r 'echo .*\".*!\"' 
     
# All sed statements
    grep -r "sed"

# All lines that start with the letter m
    grep -r "^m"

# All lines that contain three digit numbers
    grep -r '[0-9]{3}'

# All echo statements with at least three words
    grep -r 'echo (\w+\W+){3,}'
    

# References
   # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 5 - Regular expressions and text manipulation
        # 5.2 Develop your own regular expressions to improve text parsing scripts
    # https://www.youtube.com/watch?v=sa-TUpSx1JA