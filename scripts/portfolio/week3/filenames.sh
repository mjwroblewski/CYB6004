#!/bin/bash

# Check whether files and directories listed in "filenames.txt" are in "week3" folder
# Michael - 2022/02/07

grep -v '^[[:space:]]*$' filenames.txt 

for f in $(cat filenames.txt)
do
    if [ -f "$f" ]
        then
            echo "$f - That file exists."
        elif [ -d "$f" ]
            then
            echo "$f - That's a directory."
        else
            echo "$f - I don't know what that is."
    fi
done


# If that line contains a valid filename, print “That file exists”.
# If that line contains a directory name, print “That’s a directory”.
# Otherwise print “I don’t know what that is!”.
# Test your new script on “filenames.txt”.


# References
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 3 - Snippets and repetition 
        # 3.4 Write for loop statements to control program flow
    # https://www.poftut.com/linux-bash-loop-files/
    # https://stackoverflow.com/questions/3432555/remove-blank-lines-with-grep

