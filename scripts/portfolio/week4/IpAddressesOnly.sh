#!/bin/bash

# Created by Michael Wroblewski
# Date created - 2022/02/19
# Date last modified - 2022/02/28

# Script displays the computer's IP Addresses only

# Run script "IpInfo.sh"

./IpInfo.sh

##############################################################################
# NOTE: The deprecated "ifconfig" command does not work and could not
# be used in script "IpInfo.sh"
# "ifconfig" was substituted with the "ip a" command in "IpInfo.sh"
#
# Substituting "ifconfig" with the "ip a" command in "IpInfo.sh" displays the
# required output and no additional code was necessary to complete this script
##############################################################################


# References
   # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 4 - Functions and editing code
        # 4.5 Write scripts that can parse text in a meaningful way
   # https://www.howtogeek.com/657911/how-to-use-the-ip-command-on-linux/