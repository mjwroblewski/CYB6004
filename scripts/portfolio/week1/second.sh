#!/bin/bash

# Created by Michael Wroblewski
# Date created - 2022/01/24
# Date last modified - 2022/02/27

# This script introduces the use of arguments at the command line
# The argument is represented as "$1" in the script
# Enter an argument value after the script path before executing the script

echo "Hi there!"
echo "It's good to see you $1!"
exit 0

# References
#   CYB6004 - Scripting languages
#       Week 1: Introduction to Scripting and the Linux environment in a cybersecurity context
#       1.4 Write and execute simple shell scripts