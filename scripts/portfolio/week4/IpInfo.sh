#!/bin/bash 

# Display computer's network information
# Michael Wroblewski - 2022/02/19

#get info about networking from the ifconfig command 

# $(ifconfig)" command has been deprecated, substitued with "$(ip a)" 

net_info="$(ip a)" 
      
#parse out the ip address lines using sed 
      
addresses=$(echo "$net_info" | sed -n '/inet / { 
      
s/inet/IP Address:/ 
      
s/netmask/\n\t\tSubnet Mask:/ 
      
s/broadcast/\n\t\tBroadcast Address:/ 
      
p 
      
}') 
      
#format output 
      
echo -e "IP addresses on this computer are:\n$addresses" 

# References
   # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 4 - Functions and editing code
        # 4.5 Write scripts that can parse text in a meaningful way
    # https://linuxconfig.org/how-to-install-missing-ifconfig-command-on-debian-linux