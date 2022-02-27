#!/bin/bash

# Created by Michael Wroblewski
# Date created - 2022/02/12
# Date last modified - 2022/02/27

# Demonstrates use of the "grep" function and "while loop"

# Check whether files and directories listed in "filenames.txt" are in "week3" folder


grep -v '^[[:space:]]*$' filenames.txt |

while read line; do

        if [ -e $line ]; then echo "$line: This file exists."

        fi

        if [ -d $line ]; then echo "$line: This directory exists."

        fi

        if [ ! -d $line ] && [ ! -e $line ]; then echo "$line: I dont know what that is!"
    fi
done


# References
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 3 - Snippets and repetition 
        # 3.4 Write for loop statements to control program flow
    # https://www.poftut.com/linux-bash-loop-files/
    # https://stackoverflow.com/questions/3432555/remove-blank-lines-with-grep
    # https://likegeeks.com/bash-scripting-step-step-part2/

