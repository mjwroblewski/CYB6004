#!/bin/bash

# Extract selected user data from /etc/passwd and present it in a table
# Michael Wroblewski - 2022/02/21

echo "User Accounts:"

# Set the field delimiter as a :
awk -F":" '

BEGIN {
    
    printf ("_______________________________________________________________________________________________\n")

    printf ("%-31s %-21s %-21s %-31s %-30s\n","| \033[33mUsername\033[0m","| \033[33mUserID\033[0m","| \033[33mGroupID\033[0m","| \033[33mHome\033[0m","| \033[33mShell\033[0m                |");
 
    printf ("_______________________________________________________________________________________________\n");

}

{
    printf ("| %-20s | %-10s | %-10s | %-20s | %-20s |\n", $1, $3, $4, $6, $7 )

    printf ("_______________________________________________________________________________________________\n")

}' /etc/passwd

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 5: Regular expressions and text manipulation
        # 5.5 Understand and execute scripts that use AWK
    # https://www.youtube.com/watch?v=sa-TUpSx1JA
    # https://www.youtube.com/watch?v=fCw-xf31M_s
