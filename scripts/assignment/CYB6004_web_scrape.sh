#!/bin/bash

# CYB6004 Assessment 4: web scraping 

# Created by Michael Wroblewski
# Date created - 2022/02/21
# Date last modified - 2022/03/

# Script purpose:
# Scrape a cybersecurity website for cryptocurrency hacking events data
# Strip HTML code and re-format the desired text by extracting whitespace
# Extract data and present as arrays
# Create an interactive menu that filters information about the hacking events using the arrays as input data
# Implement security features including encryption and password protection

##############
#  VARIABLES #
##############

# scrape webpage, extract and format data
curl=$(which curl)
dumpfile="dump.txt"
stripfile="strip.txt"
formatfile="format.txt"
arraysfile="arrays.txt"
url="https://cryptosec.info/exchange-hacks/"

# Hack variables
# Year
2011=hack{1,2}
2012=hack{3,4,5,6}
2013=hack{7,8,9}
2014=hack{10,11,12,13,14,15,16}
2015=hack{17,18,19,20,21}
2016=hack{22,23,24,25}
2017=hack{26,27,28}
2018=hack{29,30,31,32,33,34,35,36}
2019=hack{37,38,39,40,41,42,43,44}
2020=hack{45,46,47,48,49,50}
2021=hack{51,52,53,54,55}
2022=hack56

# Currency
Currency_Bitcoin=hack{1,3,4,5,6,8,9,10,11,12,13,17,18,19,20,21,24,25,26,29}
Currency_cash=hack43
Currency_EOS=hack41
Currency_Ethereum=hack44
Currency_Multiple=hack{7,14,16,22,23,32,33,35,37,45,56}
Currency_NEM=hack30
Currency_Nano=hack31
Currency_Vericoin=hack15
Currency_undisclosed_stolen=hack{28,34,49,40,42,48,49,51,53,54,55}
Data=hack{2,27,38,46,47,50,52}

# Units stolen
Units_0-99=hack{13,29}
Units_100-999=hack{8,9,11,14,18,19,21,26}
Units_1000-9999hack{3,4,5,6,17,20}
Units_10000-99999=hack{7,10,12,16,22,24,44}
Units_100000-999999=hack{}
Units_1000000-9999999=hack{15}
Units_10000000-99999999=hack{31,37,43}
Units_>100000000=hack{30}
Units_undisclosed=hack{1,23,25,28,32,33,34,35,36,39,40,41,42,43,45,48,49,51,53,54,55,56}

# Value stolen
Val_49999=hack{29,51}
Val_50000-99999=hack{4,13,45}
Val_100000-499999=hack{3,5,6,7,18,21,23,49}
Val_500000-999999=hack{12,14,20}
Val_1000000-4999999=hack{9,11,15,19,22,25,26,37,42}
Val_5000000-9999999=hack{1,16,17,48,56}
Val_10000000-49999999=hack{32,33,34,41,43,44}
Val_50000000-99999999=hack{24,35,53,55}
Val_>100000000=hack{10,30,31,40,54}
Val_undisclosed=hack{1,23,25,28,32,33,34,35,36,39,40,41,42,43,45,48,49,51,53,54,55,56}

# Currency returned
Returned_all=hack{5,12,13,14,51}
Returned_none=hack{1,3,4,6,7,8,9,10,11,15,16,17,18,19,20,21,22,23,24,25,26,29,30,31,32,33,34,35,37,40,41,42,43,44,45,48,49,53,54,55,56}
Returned_undisclosed=hack{28,36,39}

# Hack exploit
Exploit_hot=hack{3,4,12,15,20,21,23,43,44,49,53,56}
Exploit_cold=hack{11,17,19}
Exploit_credentials=hack{1,4}
Exploit_error=hack{18}
Exploit_internal=hack{41}
Exploit_server=hack{9}
Exploit_undisclosed=hack{2,5,6,8,10,13,14,16,22,24,25,26,28,29,30,31,32,33,34,35,36,37,38,39,40,42,45,47,48,50,51,54,55}
Exploit_unsuccessful=hack{46,52}


#############
# FUNCTIONS #
#############

# "dump_webpage" function scrapes the webpage using "curl"
# Calls "check_errors" function, output error message if scrape is unsuccessful
# Outputs data to $dumpfile
  
    function dump_webpage() {
        $curl -o $dumpfile $url &>/dev/null
        check_errors
}

# "check_errors" function tests the exit code of "dump_webpage"
# Function terminates the script if exit code is not "0"

    function check_errors() {
        [ $? -ne 0 ] && echo "There was an error downloading this page..." && exit -1
    } 

# "remove_html" function removes HTML code from $dumpfile
# Outputs data to $stripfile

    function remove_html() {
        sed -i 's/&#x27;/ /g' $dumpfile
        
            grep ".*" $dumpfile | sed -n '/[<h3><li>]/ {
	            s/<[^>]*>//g
		        s/&#8217;//g
                p
	        }' > $stripfile
        
                sed -i '1,/id="ha-large-header" -->/d' $stripfile        
    }

# "formatting" function removes whitespace and multiple blank lines from $stripfile
# Outputs data to $formatfile

    function formatting() {
        sed -i 's/^[\t]*//;s/^[\t]*$//;s/[ ]\+/ /g' $stripfile    
            grep . -A1 $stripfile | grep -v "^--$"

    } > $formatfile 





######################################################################################################
# NOTE: The next step was to extract hacking event data from $formatfile                             #                 
# Despite best efforts this was not achieved within the timeframe                                    #
# The process would have proceeded as follows                                                        #
#                                                                                                    #
# Extracted data would be split into columns for each element:                                       #
# Hack #:Year:Exchange:Currency:Units:Value stolen:Value recovered:Hack type/vulnerability exploited #
# Elements would be outputted as arrays to $arraysfile and used as inputs for subsequent script      #
# The arrays are presented below                                                                     #
# The script will next execute the "arrays" function and output the arrays to $arraysfile            # 
#                                                                                                    # 
    hack1="1:2011:Mt Gox:Bitcoin:Undisclosed:8,750,000:0:Stolen credentials"                         # 
    hack2="2:2011:Bitcoin7:-:-:-:-:Data - Undisclosed"                                               # 
    hack3="3:2012:Bitcoinica:Bitcoin:43,554:228,000:0:Hot wallet"                                    # 
    hack4="4:2012:Bitcoinica:Bitcoin:38,000:87,000:0:Hot wallet"                                     # 
    hack5="5:2012:Bitcoinica:Bitcoin:40,000:300,000:300,000:Undisclosed"                             # 
    hack6="6:2012:Bitfloor:Bitcoin:24,000:250,000:0:Undisclosed"                                     # 
    hack7="7:2013:Vircurex:Various:250,117:352,000:0:Stolen credentials"                             # 
    hack8="8:2013:Picostocks:Bitcoin:1,300:Undisclosed:0:Undisclosed"                                    # 
    hack9="9:2013:Inputs.io:Bitcoin:4,100:1,200,000:0:Server vulnerability"                          # 
    hack10="10:2014:Mt Gox:Bitcoin:844,408:661,348,000:0:Undisclosed"                                # 
    hack11="11:2014:Picostocks:Bitcoin:5,896:4,434,000:0:Cold wallet"                                # 
    hack12="12:2014:Flexcoin:Bitcoin:896:600,000:600,000:Hot wallet"                                 # 
    hack13="13:2014:Poloniex:Bitcoin:97:67,500:67,500:Undisclosed"                                   #
    hack14="14:2014:Crypto Rush:Various:3,450:630,000:630,000:Undisclosed"                           #
    hack15="15:2014:MintPal:Vericoin:8,000,000:1,933,000:0:Hot wallet"                               #
    hack16="16:2014:Cryptysy:Various:313,000:9,580,000:0:Undisclosed"                                #
    hack17="17:2015:Bitstamp:Bitcoin:19,000:5,100,000:0:Cold wallet"                                 # 
    hack18="18:2015:796:Bitcoin:1,000:270,000:0:Internal error"                                      #
    hack19="19:2015:BTER:Bitcoin:7,170:1,750,000:0:Cold wallet"                                      #
    hack20="20:2015:KipCoin:Bitcoin:3,000:728,000:0:Hot wallet"                                      #
    hack21="21:2015:Bitfinex:Bitcoin:1,400:329,000:0:Hot wallet"                                     #
    hack22="22:2016:Gatecoin:Various:185,250:2,140,000:0:Undisclosed"                                #
    hack23="23:2016:ShapeShift:Various:Undisclosed:200,000:0:Hot wallet"                             #
    hack24="24:2016:Bitfinex:Bitcoin:120,000:72,000,000:0:Undisclosed"                               #
    hack25="25:2016:Bitcurex:Bitcoin:Undisclosed:1,500,000:0:Undisclosed"                            #
    hack26="26:2017:Yapizon:Bitcoin:3,831:4,850,000:0:Undisclosed"                                   #
    hack27="27:2017:Bithumb:-:-:-:-:Data - Undisclosed"                                              #
    hack28="28:2017:YouBit:Undisclosed:Undisclosed:Undisclosed:Undisclosed:Undisclosed"              #
    hack29="29:2018:LocalBitcoins:Bitcoin:7.9:27,000:0:Undisclosed"                                  # 
    hack30="30:2018:Coincheck:NEM:500,000,000:500,000,000:0:Undisclosed"                             #
    hack31="31:2018:BitGrail:Nano:17,000,000:170,000,000:0:Undisclosed"                              #
    hack32="32:2018:Coinrail:Various:Undisclosed:40,000,000:0:Undisclosed"                           #
    hack33="33:2018:Bithumb:Various:Undisclosed:31,000,000:0:Undisclosed"                            #
    hack34="34:2018:Bancor:Undisclosed:Undisclosed:23,000,000:0:Undisclosed"                         #
    hack35="35:2018:Zaif:Various:Undisclosed:60,000,000:0:Undisclosed"                               #
    hack36="36:2018:MapleChange:Undisclosed:Undisclosed:Undisclosed:Undisclosed:Undisclosed"         #
    hack37="37:2019:Cryptopia:Various:48,019,391:3,620,000:0:Undisclosed"                            # 
    hack38="38:2019:Coinmama:-:-:-:-:Data - Undisclosed"                                             #
    hack39="39:2019:DragonEX:Undisclosed:Undisclosed:Undisclosed:Undisclosed:Undisclosed"            #
    hack40="40:2019:Coinbene:Undisclosed:Undisclosed:100,000,000:0:Undisclosed"                      #
    hack41="41:2019:Bithumb:EOS:Undisclosed:13,000,000:0:Internal theft"                             #
    hack42="42:2019:Bitrue:Undisclosed:Undisclosed:4,200,000:0:Undisclosed"                          #
    hack43="43:2019:BITPoint:Cash:32,000,000:32,000,000:0:Hot wallet"                                #
    hack44="44:2019:Upbit:Ethereum:342,000:49,000,000:0:Hot wallet"                                  #
    hack45="45:2020:Altsbit:Various:Undisclosed:73,000:0:Undisclosed"                                # 
    hack46="46:2020:BlockFi:-:-:-:-:Unsuccessful"                                                    #
    hack47="47:2020:BuyUcoin:-:-:-:-:Data - Undisclosed"                                             #
    hack48="48:2020:Eterbase:Undisclosed:Undisclosed:5,400,000:0:Undisclosed"                        #
    hack49="49:2020:KuCoin:Undisclosed:Undisclosed:280,000:0:Hot wallet key theft"                   #
    hack50="50:2020:Livecoin:-:-:-:-:Undisclosed"                                                    #
    hack51="51:2021:Cryptopia:Undisclosed:Undisclosed:45,000:45,000:Undisclosed"                     # 
    hack52="52:2021:Hotbit:-:-:-:-:Unsuccessful"                                                     #
    hack53="53:2021:Liquid:Undisclosed:Undisclosed:80,000,000:0:Hot wallet"                          #
    hack54="54:2021:BitMart:Undisclosed:Undisclosed:150,000,000:0:Undisclosed"                       #
    hack55="55:2021:AscendEX:Undisclosed:Undisclosed:78,000,000:0:Undisclosed"                       #
    hack56="56:2022:LCX:Various:Undisclosed:6,800,000:0:Hot wallet"                                  # 
                                                                                                     #
######################################################################################################

# "arrays" function inserts a delimiter "#" at the beginning of variables "$hack1 - $hack56
# then copies variables to $arraysfile
# "sed" inserts line breaks at delimiters, deletes the blank top line then deletes the delimeter

    function arrays() {

        echo -e \#$hack{1..56} > arrays.txt

            sed -i 's/#/\n&/g' $arraysfile

                sed -i '1d' $arraysfile
    
                    sed -i 's/#//g' $arraysfile

    } 


# Extract selected all data from $arraysfile and present it in a table format

    echo "Crypto Exchange Hacks:"

# Set the field delimiter as a :

    function table_all_data() {

        awk -F":" '

        BEGIN {
    
        printf ("___________________________________________________________________________________________________________________\n");

        printf ("%-15s %-15s %-24s %-23s %-23s %-22s %-23s %-30s \n","| \033[33mHack\033[0m","| \033[33mYear\033[0m","| \033[33mExchange\033[0m","| \033[33mCurrency\033[0m","| \033[33mUnits\033[0m"," | \033[33m\$Value\033[0m"," | \033[33m\$Returned\033[0m"," | \033[33mVulnerability\033[0m          |");
 
        printf ("___________________________________________________________________________________________________________________\n");

    }

    {
        printf ("| %-4s | %-4s | %-13s | %-12s | %-13s | %-11s | %-12s | %-22s |\n", $1, $2, $3, $4, $5, $6, $7, $8 );

        printf ("___________________________________________________________________________________________________________________\n")

    }' arrays.txt

    }

 
#########################
# MENUS

# Main menu
    # Introduce the program
    # What does it do
    # Instructions
    # OPTIONS
        # 1. Show all hacking event data        > table_all_data
        # 2. Search hacks by year(s)            
            # Enter a year                  
                # 2.1 2011                      > $
                    # List                      > $
                    # Count                     > $
                    # Total                     > $
                    # 2.1.1 Back                > $
                    # 2.1.2 Exit                > $
                # 2.2 2012                      > $
                    # List                      > $
                    # Count                     > $
                    # Total                     > $
                    # 2.2.1 Back                > $
                    # 2.2.2 Exit                > $
                # 2.3 2013                      > $
                    # List                      > $
                    # Count                     > $
                    # Total                     > $
                    # 2.3.1 Back                > $
                    # 2.3.2 Exit                > $                
                # 2.4 2014                      > $
                    # List                      > $
                    # Count                     > $
                    # Total                     > $
                    # 2.4.1 Back                > $
                    # 2.4.2 Exit                > $                                
                # 2.5 2015                      > $
                    # List                      > $
                    # Count                     > $
                    # Total                     > $
                    # 2.5.1 Back                > $
                    # 2.5.2 Exit                > $                
                # 2.6 2016                      > $
                    # List                      > $
                    # Count                     > $
                    # Total                     > $
                    # 2.6.1 Back                > $
                    # 2.6.2 Exit                > $                                
                # 2.7 2017                      > $
                    # List                      > $
                    # Count                     > $
                    # Total                     > $
                    # 2.7.1 Back                > $
                    # 2.7.2 Exit                > $                                
                # 2.8 2018                      > $
                    # List                      > $
                    # Count                     > $
                    # Total                     > $
                    # 2.8.1 Back                > $
                    # 2.8.2 Exit                > $                
                # 2.9 2019                      > $
                    # List                      > $
                    # Count                     > $
                    # Total                     > $
                    # 2.9.1 Back                > $
                    # 2.9.2 Exit                > $                
                # 2.10 2020                     > $
                    # List                      > $
                    # Count                     > $
                    # Total                     > $
                    # 2.10.1 Back               > $
                    # 2.10.2 Exit               > $                
                # 2.11 2021                     > $
                    # List                      > $
                    # Count                     > $
                    # Total                     > $
                    # 2.11.1 Back               > $
                    # 2.11.2 Exit               > $                
                # 2.12 2022                     > $
                    # List                      > $
                    # Count                     > $
                    # Total                     > $
                    # 2.12.1 Back               > $
                    # 2.12.2 Exit               > $
                # 2.13 Back                     > $
                # 2.14 Exit                     > $

        # 2. Search by currency stolen
            # 2.1 Bitcoin                       > $Currency_Bitcoin
                # 2.1.1                         > $
                # 2.1.2                         > $
                # 2.1.3                         > $
            # 2.2 EOS                           > $Currency_EOS
                # 2.2.1                         > $
                # 2.2.2                         > $
                # 2.2.3                         > $
            # 2.3 Ethereum                      > $Currency_Ethereum
                # 2.3.1                         > $
                # 2.3.2                         > $
                # 2.3.3                         > $
            # 2.4 NEM                           > $Currency_NEM
                # 2.4.1                         > $
                # 2.4.2                         > $
                # 2.4.3                         > $
            # 2.5 Nano                          > $Currency_Nano
                # 2.5.1                         > $
                # 2.5.2                         > $
                # 2.5.3                         > $
            # 2.6 Vericoin                      > $Currency_Verizon
                # 2.6.1                         > $
                # 2.6.2                         > $
                # 2.6.3                         > $
            # 2.7 Multiple currencies           > $Currency_multiple
                # 2.7.1                         > $
                # 2.7.2                         > $
                # 2.7.3                         > $
            # 2.8 Undisclosed                   > $Currency_undisclosed
                # 2.8.1                         > $
                # 2.8.2                         > $
                # 2.8.3                         > $
            # 2.9 Cash                          > $Currency_cash
                # 2.9.1                         > $
                # 2.9.2                         > $
                # 2.9.3                         > $
            # 2.10 Data                         > $Data
                # 2.10.1                        > $
                # 2.10.2                        > $
                # 2.10.3                        > $
        
        # 4. Search by number of units stolen
            # 3.1 <100                          > $Units_0-99
                # 3.1.1                         > $
                # 3.1.2                         > $
                # 3.1.3                         > $
            # 3.2 100 - 999                     > $Units_100-999
                # 3.2.1                         > $
                # 3.2.2                         > $
                # 3.2.3                         > $
            # 3.3 1,000 - 9,999                 > $Units_1000-9999
                # 3.3.1                         > $
                # 3.3.2                         > $
                # 3.3.3                         > $    
            # 3.4 10,000 - 99,999               > $Units_10000-99999
                # 3.4.1                         > $
                # 3.4.2                         > $
                # 3.4.3                         > $
            # 3.5 100,000 - 999,999             > $Units_100000-999999
                # 3.5.1                         > $
                # 3.5.2                         > $
                # 3.5.3                         > $
            # 3.6 1,000,000 - 9,999,999         > $Units_1000000-9999999
                # 3.6.1                         > $
                # 3.6.2                         > $
                # 3.6.3                         > $
            # 3.7 10,000,000 - 99,999,999       > $Units_10000000-99999999
                # 3.7.1                         > $
                # 3.7.2                         > $
                # 3.7.3                         > $
            # 3.8 > 100,000,000                 > $Units_>100000000
                # 3.8.1                         > $
                # 3.8.2                         > $
                # 3.8.3                         > $
            # 3.9 Undisclosed                   > $Units_undisclosed
                # 3.9.1                         > $
                # 3.9.2                         > $
                # 3.9.3                         > $

        # 4. Search by value stolen
            # 4.1 <$50,000                      > $Val_49999
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 4.1.1 Back                    > $
                # 4.1.2 Exit                    > $
            # 4.2 $50,000 - $99,999             > $Val_50000-99999
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 4.2.1 Back                    > $
                # 4.2.2 Exit                    > $                
            # 4.3 $100,000 - $499,999           > $Val_100000-499999
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 4.3.1 Back                    > $
                # 4.3.2 Exit                    > $                
            # 4.4 $500,000 - $999,999           > $Val_500000-999999
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 4.4.1 Back                    > $
                # 4.4.2 Exit                    > $                
            # 4.5 $1,000,000 - $4,999,999       > $Val_1000000-4999999
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 4.5.1 Back                    > $
                # 4.5.2 Exit                    > $                
            # 4.6 $5,000,000 - $9,999,999       > $Val_5000000-9999999
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 4.6.1 Back                    > $
                # 4.6.2 Exit                    > $                
            #4.7 $10,000,000 - $49,999,999      > $
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 4.7.1 Back                    > $
                # 4.7.2 Exit                    > $                
            # 4.8 $50,000,000 - $99,999,999     > $Val_50000000-99999999
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 4.8.1 Back                    > $
                # 4.8.2 Exit                    > $                
            # 4.9 > $100,000,000                > $Val_>100000000
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 4.9.1 Back                    > $
                # 4.9.2 Exit                    > $                
            # 4.10 Summary                      > $
                # 4.10.1 Back                   > $
                # 4.10.2 Exit                   > $            
        
        # 5. Search by funds recovered
            # 5.1 Yes                           > $Returned_all
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 5.1.1 Back                    > $
                # 5.1.2 Exit                    > $                
            # 5.2 No                            > $Returned_none
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 5.2.1 Back                    > $
                # 5.2.2 Exit                    > $                
            # 5.3 Undisclosed                   > $Returned_undisclosed
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 5.3.1 Back                    > $
                # 5.3.2 Exit                    > $                
            # 5.4 Summary                       > $
                # 5.4.1 Back                    > $
                # 5.4.2 Exit                    > $            

        # 6. Search by exploit
            # 6.1 Hot wallet                    > $Exploit_hot
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 6.1.1 Back                    > $
                # 6.1.2 Exit                    > $                
            # 6.2 Cold wallet                   > $Exploit_cold
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 6.2.1 Back                    > $
                # 6.2.2 Exit                    > $                          
            # 6.3 Credential theft              > $Exploit_credentials
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 6.3.1 Back                    > $
                # 6.3.2 Exit                    > $                            
            # 6.4 Internal error                > $Exploit_error
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 6.4.1 Back                    > $
                # 6.4.2 Exit                    > $                         
            # 6.5 Internal theft                > $Exploit_internal
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 6.5.1 Back                    > $
                # 6.5.2 Exit                    > $                           
            # 6.6 Server error                  > $Exploit_server
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 6.6.1 Back                    > $
                # 6.7.2 Exit                    > $                          
            # 6.7 Undisclosed                   > $Exploit_undisclosed
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 6.7.1 Back                    > $
                # 6.7.2 Exit                    > $                          
            # 6.8 Unsuccessful                  > $Exploit_unsuccessful
                # List                          > $
                # Count                         > $
                # Total                         > $
                # 6.8.1 Back                    > $
                # 6.8.2 Exit                    > $                
            # 6.9 Summary                       > $
            # 6.10 Back                         > $
            # 6.11 Exit                         > $

        # 7. Exit                               > $


#######################
# Menu functions




# Case functions


##################
# Code execution #
##################

dump_webpage
remove_html
formatting
arrays
formatting
table_all_data



# REFERENCES

# https://www.youtube.com/watch?v=DZ0WKRmUTm4 
# https://linuxhandbook.com/display-specific-lines/
# https://ostechnix.com/add-line-numbers-text-files-linux/
# https://linuxhint.com/sed_remove_whitespace/
# https://stackoverflow.com/questions/922449/how-can-i-replace-multiple-empty-lines-with-a-single-empty-line-in-bash
# https://askubuntu.com/questions/1206110/sed-extract-lines-from-text
# https://www.unix.com/shell-programming-and-scripting/134483-insert-line-break.html
# https://www.unix.com/shell-programming-and-scripting/210171-how-sort-column-unix-colon-separated.html
# https://dev.to/meleu/how-to-join-array-elements-in-a-bash-script-303a
# https://guide.bash.academy/expansions/
# https://devhints.io/bash

# References:
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 5: Regular expressions and text manipulation
        # 5.5 Understand and execute scripts that use AWK
    # https://www.youtube.com/watch?v=sa-TUpSx1JA
    # https://www.youtube.com/watch?v=fCw-xf31M_s



## Number lines
#function count_lines() {
#    LINES=$(cat $formatted)
#    LineNumber=0
#    for LINE in $LINES
#    do
#    echo ":Line $LineNumber: $LINE" >> $numbered
#    LineNumber=$((LineNumber+1))
# done
#}

# Unsuccessful function for data extraction
    #function extract_data() {
        #grep "Crypto" $numbered | sed -e '/[Line1|Line1000]/p' > extracted.txt
        #echo $numbered | sed -n '/Crypto/p' > extracted.txt
        #egrep '1|100' $numbered $extracted
        #sed -n '/^[1|100]/p' $numbered
        #awk -i 'NR>=1 && NR<= 100' $numbered
    #}

# Unused HTML removal commands
    #sed -i '/<h3>.*&#8211;.*<\/h3>/,$!d' $outfile
    #sed -i '/482180/q' $outfile
    #sed -i '/<h3>.*<\/h3>/,$!d' $outfile
    #sed -i '/<h3>.*\\d{4}<\/h3>/,$!d' $outfile    
    
# Unused variables
    #numbered="numbered.txt"
    #extract="extracted.txt"
    #tabledata="table.txt"
    #regex="<p>$1"
    #searchterm=$(echo $1 | tr ' ' '+')
