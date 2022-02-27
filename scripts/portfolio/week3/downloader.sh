#!/bin/bash

# Created by Michael Wroblewski
# Date created - 2022/02/08
# Date last modified - 2022/02/28

# Demonstrate use of webpage downloader "wget"
# The script fails if a value other than "q" is entered to quit
# The script fails if values including \/:*?"<>| are used in directory name

# Download a webpage and save to a selected location

echo "Welcome to the webpage downloader."

read -p "Please type the webpage URL to download, or enter 'q' to quit: " URL

    # Script terminates if user selects 'q'
    # Script fails if a value other than "q" is entered to quit

if [ "$URL" = "q" ]; then
    echo "Goodbye!"

    exit 0

else

    read -p "Please type the directory to save the webpage: " DLOC
        
        wget -p $DLOC $URL

    echo "Website has been downloaded."

fi

exit 0


# References
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 3 - Snippets and repetition 
        # 3.5 An internet downloader using loops
    # https://linuxconfig.org/download-file-from-url-on-linux-using-command-line
    # https://alvinalexander.com/linux-unix/wget-command-shell-script-example-download-url/
    # https://www.hostinger.com/tutorials/wget-command-examples/
    # https://likegeeks.com/bash-scripting-step-step-part2/
