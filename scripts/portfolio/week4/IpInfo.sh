#!/bin/bash 

# Created by Michael Wroblewski
# Date created - 2022/02/19
# Date last modified - 2022/02/28

# Demonstrates the use of "sed" command
# Script displays the computer's network information

###########################################################################
# NOTE: The deprecated "ifconfig" command does not work and could not
# be used in script "IpInfo.sh"
# "ifconfig" was substituted with the "ip a" command
###########################################################################

net_info="$(ip a)" 
      
# Parse out the ip address lines using sed 
      
addresses=$(echo "$net_info" | sed -n '/inet / { 
      
s/inet/IP Address:/ 
      
s/netmask/\n\t\tSubnet Mask:/ 
      
s/broadcast/\n\t\tBroadcast Address:/ 
      
p 
      
}') 
      
# Outputs the IP addresses
      
echo -e "IP addresses on this computer are:\n$addresses" 

# References
   # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 4 - Functions and editing code
        # 4.5 Write scripts that can parse text in a meaningful way
    # https://linuxconfig.org/how-to-install-missing-ifconfig-command-on-debian-linux