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

# 1.0 Data scraping and extraction code

#################
# 1.1 VARIABLES #
#################

curl=$(which curl)
dumpfile="dump.txt"
stripfile="strip.txt"
formatfile="format.txt"
elementfile="element.txt"
url="https://cryptosec.info/exchange-hacks/"


#################
# 1.2 FUNCTIONS #
#################

# Scrape webpage using "dump_webpage" function
# Run "check_errors" function to display error message if scrape was unsuccessful
# Output data as $dumpfile
  
function dump_webpage() {
    $curl -o $dumpfile $url &>/dev/null
    check_errors
}

function check_errors() {
    [ $? -ne 0 ] && echo "There was an error downloading this page..." && exit -1
} 

# Remove HTML code from $dumpfile using "remove_html" function
# Output as $stripfile

function remove_html() {
    sed -i 's/&#x27;/ /g' $dumpfile
        
        grep ".*" $dumpfile | sed -n '/[<h3><li>]/ {
	        s/<[^>]*>//g
		    s/&#8217;//g
            p
	    }' > $stripfile
        sed -i '1,/id="ha-large-header" -->/d' $stripfile        
}

# Remove whitespace and multiple blank lines from $stripfile using "formatting" function
# Output as $formatfile

function formatting() {
    sed -i 's/^[\t]*//;s/^[\t]*$//;s/[ ]\+/ /g' $stripfile    
    grep . -A1 $stripfile | grep -v "^--$"

} > $formatfile 

######################################################################################################
# NOTE: The next step was to extract data from $formatfile for each hacking event                    #
# Despite best efforts this couldn't be achieved                                                     #
# The process would have proceeded as follows                                                        #
#                                                                                                    #
# Extracted data would be split into columns for each element:                                       #
# Hack #:Year:Exchange:Currency:Units:Value stolen:Value recovered:Hack type/vulnerability exploited #
# Elements would be outputted as arrays to $elementfile                                              #
# The arrays are presented below as variables                                                        #
#                                                                                                    # 
    hack1="1:2011:Mt Gox:Bitcoin:NA:8,750,000:0:Stolen credentials"
    hack2="2:2011:Bitcoin7:NA:NA:NA:NA:Hack"
    hack3="3:2012:Bitcoinica:Bitcoin:43,554:228,000:0:Hot wallet"
    hack4="4:2012:Bitcoinica:Bitcoin:38,000:87,000:0:Repeat attack"
    hack5="5:2012:Bitcoinica:Bitcoin:40,000:300,000:300,000:Hack"
    hack6="6:2012:Bitfloor:Bitcoin:24,000:250,000:0:Hack"
    hack7="7:2013:Vircurex:Various:250,117:352,000:0:Stolen credentials"
    hack8="18:2013:Picostocks:Bitcoin:1,300:Unknown:0:Hack"
    hack9="9:2013:Inputs.io:Bitcoin:4,100:1,200,000:0:Data theft"
    hack10="10:2014:Mt Gox:Bitcoin:844,408:661,348,000:0:Hack"
    hack11="11:2014:Mt Gox:Bitcoin:844,408:661,348,000:0:Hack"
    hack12="12:2014:Picostocks:Bitcoin:5,896:4,434,000:0:Cold wallet"
    hack13="13:2014:Flexcoin:Bitcoin:896:600,000:600,000:0:Hot wallet"
    hack14="14:2014:Poloniex:Bitcoin:97:67,500:67,500:Hack"
    hack15="15:2014:Crypto Rush:Various:3,450:630,000:630,000:Hack"
    hack16="16:2014:MintPal:Vericoin:8,000,000:1,933,000:0:Hot wallet"
    hack17="17:2014:Cryptysy:Various:313,000:9,580,000:0:Hack"
    hack18="18:2015:Bitstamp:Bitcoin:19,000:5,100,000:0:Cold wallet"
    hack19="19:2015:796:Bitcoin:1,000:270,000:0:Internal error"
    hack20="20:2015:BTER:Bitcoin:7,170:1,750,000:0:Cold wallet"
    hack21="21:2015:KipCoin:Bitcoin:3,000:728,000:0:Hot wallet"
    hack22="22:2015:Bitfinex:Bitcoin:1,400:329,000:0:Hot wallet"
    hack23="23:2016:Gatecoin:Various:185,250:2,140,000:0:Hack"
    hack24="24:2016:ShapeShift:Various:Unknown:200,000:0:Hot wallet"
    hack25="25:2016:Bitfinex:Bitcoin:120,000:72,000,000:0:Hack"
    hack26="26:2016:Bitcurex:Bitcoin:Unknown:1,500,000:0:Hack"
    hack27="27:2017:Yapizon:Bitcoin:3,831:4,850,000:0:Hack"
    hack28="28:2017:Bithumb:NA:NA:NA:NA:Data theft"
    hack29="29:2017:YouBit:Unknown:Unknown:Unknown:0:Hack"
    hack30="30:2018:LocalBitcoins:Bitcoin:7.9:27,000:0:Hack"
    hack31="31:2018:Coincheck:NEM:500,000,000:500,000,000:0:Hack"
    hack32="32:2018:BitGrail:Nano:17,000,000:170,000,000:0:Hack"
    hack33="33:2018:Coinrail:Various:Unknown:40,000,000:0:Hack"
    hack34="34:2018:Bithumb:Various:Unknown:31,000,000:0:Hack"
    hack35="35:2018:Bancor:Unknown:Unknown:23,000,000:0:Hack"
    hack36="36:2018:Zaif:Various:Unknown:60,000,000:0:Hack"
    hack37="37:2018:MapleChange:Unknown:Unknown:Unknown:0:Hack"
    hack38="38:2019:Cryptopia:Various:48,019,391:3,620,000:0:Hack"
    hack39="39:2019:Coinmama:NA:NA:NA:NA:Data theft"
    hack40="40:2019:DragonEX:Unknown:Unknown:Unknown:Hack"
    hack41="41:2019:Coinbene:Unknown:Unknown:100,000,000:0:Hack"
    hack42="42:2019:Bithumb:EOS:Unknown:13,000,000:0:Internal theft"
    hack43="43:2019:Bitrue:Unknown:Unknown:4,200,000:0:Hack"
    hack44="44:2019:BITPoint:Cash:32,000,000:32,000,000:0:Hot wallet"
    hack45="45:2019:Upbit:Ethereum:342,000:49,000,000:0:Hot wallet"
    hack46="46:2020:Altsbit:Various:Unknown:73,000:0:Hack"
    hack47="47:2020:BlockFi:NA:NA:NA:NA:Unsuccessful"
    hack48="48:2020:BuyUcoin:NA:NA:NA:NA:Customer data"
    hack49="49:2020:Eterbase:Unknown:Unknown:5,400,000:0:Hack"
    hack50="50:2020:KuCoin:Unknown:Unknown:280,000:0:Hot wallet key theft"
    hack51="51:2020:Livecoin:NA:NA:NA:NA:Hack"
    hack52="52:2021:Cryptopia:Unknown:Unknown:45,000:45,000:Hack"
    hack53="53:2021:Hotbit:NA:NA:NA:NA:Unsuccessful"
    hack54="54:2021:Liquid:Unknown:Unknown:80,000,000:0:Hot wallet"
    hack55="55:2021:BitMart:Unknown:Unknown:150,000,000:0:Hack"
    hack56="56:2021:AscendEX:Unknown:Unknown:78,000,000:0:Hack"
    hack57="57:2022:LCX:Various:Unknown:6,800,000:0:Hot wallet"
#                                                                                                    #
# The script will next output these variables as $elements and continue as planned                   #
######################################################################################################


 






	


  

######################
# 1.3 Code execution #
######################

dump_webpage
remove_html
formatting
















# REFERENCES

# https://www.youtube.com/watch?v=DZ0WKRmUTm4 
# https://linuxhandbook.com/display-specific-lines/
# https://ostechnix.com/add-line-numbers-text-files-linux/
# https://linuxhint.com/sed_remove_whitespace/
# https://stackoverflow.com/questions/922449/how-can-i-replace-multiple-empty-lines-with-a-single-empty-line-in-bash
# https://askubuntu.com/questions/1206110/sed-extract-lines-from-text



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