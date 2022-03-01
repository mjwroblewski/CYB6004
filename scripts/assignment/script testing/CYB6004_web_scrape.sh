# CYB6004 Assessment 4: web scraping 
# Michael Wroblewski - 2022/02/

# Scrape a cybersecurity website for cryptocurrency hacking events data
# Strip HTML code and re-format the desired text by extracting whitespace
# Extract data and present as arrays
# Create an interactive menu that filters information about the hacking events using the arrays as input data
# Implement security features including encryption and password protection

# SCRIPT CONTENT
# 1.0 Data scraping and extraction code
#   1.1 Variables
#   1.2 Functions
#   1.3 Code execution
# 2.0 Menu development code
#   2.1 Variables
#   2.2 Functions
#   2.3 Execution
# 3.0 Security feature code
#   3.1 Variables
#   3.2 Functions
#   3.3 Execution

#!/bin/bash

########################################
# 1.0 Data scraping and extraction code

#################
# 1.1 VARIABLES #
#################

curl=$(which curl)
dumpfile="dump.txt"
stripfile="strip.txt"
formatfile="format.txt"
arraysfile="arrays.txt"
url="https://cryptosec.info/exchange-hacks/"


#################
# 1.2 FUNCTIONS #
#################

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
# Elements would be outputted as arrays to $elementfile and used as inputs for subsequent script     #
# The arrays are presented below                                                                     #
# The script will next execute the "elements" function and output the arrays to $arraysfile          # 
#                                                                                                    #
    hack1="1:2011:Mt Gox:Bitcoin:NA:8,750,000:0:Stolen credentials"                                  #
    hack2="2:2011:Bitcoin7:-:-:-:-:Data - Undisclosed"                                               #
    hack3="3:2012:Bitcoinica:Bitcoin:43,554:228,000:0:Hot wallet"                                    #
    hack4="4:2012:Bitcoinica:Bitcoin:38,000:87,000:0:Hot wallet"                                     #
    hack5="5:2012:Bitcoinica:Bitcoin:40,000:300,000:300,000:Undisclosed"                             #
    hack6="6:2012:Bitfloor:Bitcoin:24,000:250,000:0:Undisclosed"                                     #
    hack7="7:2013:Vircurex:Various:250,117:352,000:0:Stolen credentials"                             #
    hack8="8:2013:Picostocks:Bitcoin:1,300:Unknown:0:Undisclosed"                                    #
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
    hack23="23:2016:ShapeShift:Various:Unknown:200,000:0:Hot wallet"                                 #
    hack24="24:2016:Bitfinex:Bitcoin:120,000:72,000,000:0:Undisclosed"                               #
    hack25="25:2016:Bitcurex:Bitcoin:Unknown:1,500,000:0:Undisclosed"                                #
    hack26="26:2017:Yapizon:Bitcoin:3,831:4,850,000:0:Undisclosed"                                   #
    hack27="27:2017:Bithumb:-:-:-:-:Data - Undisclosed"                                              #
    hack28="28:2017:YouBit:Undisclosed:Undisclosed:Undisclosed:0:Undisclosed"                        #
    hack29="29:2018:LocalBitcoins:Bitcoin:7.9:27,000:0:Undisclosed"                                  #
    hack30="30:2018:Coincheck:NEM:500,000,000:500,000,000:0:Undisclosed"                             #
    hack31="31:2018:BitGrail:Nano:17,000,000:170,000,000:0:Undisclosed"                              #
    hack32="32:2018:Coinrail:Various:Undisclosed:40,000,000:0:Undisclosed"                           #
    hack33="33:2018:Bithumb:Various:Undisclosed:31,000,000:0:Undisclosed"                            #
    hack34="34:2018:Bancor:Undisclosed:Undisclosed:23,000,000:0:Undisclosed"                         #
    hack35="35:2018:Zaif:Various:Undisclosed:60,000,000:0:Undisclosed"                               #
    hack36="36:2018:MapleChange:Undisclosed:Undisclosed:Undisclosed:0:Undisclosed"                   #
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
 


######################
# 1.3 Code execution #
######################

dump_webpage
remove_html
formatting
arrays
formatting


#########################################################
# 2.0 Menu development

###################
# 2.1 - Variables #
###################



# Extract selected user data from /etc/passwd 
# Present data in a table format
# Table headings shown in brown

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

table_all_data

#########################
# MENUS

# Main menu
    # Introduce the program
    # What does it do
    # Instructions
    # OPTIONS
        # Attacks
            # OPTIONS
                # Select a year
                    # How many attacks
                    # How much was stolen

        # Currencies
        # Amounts



# Atacks: by year, currency, sort by value
# Currency: types, units stolen, value stolen, totals
# Values: stolen, retuned, totals
# Exchanges: by year, multiple attacks
# Vulnerabilities
# Data only
# Filter out Undisclosed


# Case functions






# REFERENCES

# https://www.youtube.com/watch?v=DZ0WKRmUTm4 
# https://linuxhandbook.com/display-specific-lines/
# https://ostechnix.com/add-line-numbers-text-files-linux/
# https://linuxhint.com/sed_remove_whitespace/
# https://stackoverflow.com/questions/922449/how-can-i-replace-multiple-empty-lines-with-a-single-empty-line-in-bash
# https://askubuntu.com/questions/1206110/sed-extract-lines-from-text
# https://www.unix.com/shell-programming-and-scripting/134483-insert-line-break.html

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
