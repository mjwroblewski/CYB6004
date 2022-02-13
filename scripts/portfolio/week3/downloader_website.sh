#!/bin/bash

# Download an entire website and save to selected location
# Michael 2022/02/13

echo "Welcome to the website downloader."

read -p "Please type the website URL to download, or enter 'q' to quit: " URL

if [ "$URL" = "q" ]; then
    echo "Goodbye!"
    
    exit 0

    break

else
    read -p "Please type the website download location: " DLOC
    
        wget --mirror --convert-links --page-requisites --no-parent -P $DLOC $URL

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
