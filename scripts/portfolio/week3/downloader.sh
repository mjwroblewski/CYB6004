#!/bin/bash

echo "Welcome to the website downloader."
read -p "Please type the website URL to download, or enter 'q' to quit: " URL



if [ "$URL" = "q" ]; then
    echo "Goodbye!"
    
    exit 0

break

else
    read -p "Please type the website download location: " DLOC
    
fi

wget --mirror --convert-links --page-requisites --no-parent -P $DLOC $URL

#E:/Education/Cyber_Security/ECU/CYB6004-Scripting_languages/home/student/scripts/ 

# documents/websites/ $URL

# wget $URL -o -r -p 

echo "Website has been downloaded."

exit -0


# References
#
#
# https://linuxconfig.org/download-file-from-url-on-linux-using-command-line
# https://alvinalexander.com/linux-unix/wget-command-shell-script-example-download-url/
# https://www.hostinger.com/tutorials/wget-command-examples/
