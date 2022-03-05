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

# Password variables
Pass_unlock_hash=$(echo "$Pass_unlock" | sha256sum)
Pass_lock="Password/not_a_password.txt"
Pass_lock_hash=$(cat "$Pass_lock")

# Formatting variables
black="\033[30m"
red="\033[31m"
green="\033[32m"
brown="\033[33m"
blue="\033[34m"
purple="\033[35m"
cyan="\033[36m"
clear="\033[0m"

# Data extraction variables
# Scrape webpage, extract and format data
curl=$(which curl)
dumpfile="dump.txt"
stripfile="strip.txt"
formatfile="format.txt"
arraysfile="arrays.txt"
url="https://cryptosec.info/exchange-hacks/"




# Hacking event variables

# Year
Y_2011_file="Y_2011_file.txt"
Y_2012_file="Y_2012_file.txt"
Y_2013_file="Y_2013_file.txt"
Y_2014_file="Y_2014_file.txt"
Y_2015_file="Y_2015_file.txt"
Y_2016_file="Y_2016_file.txt"
Y_2017_file="Y_2017_file.txt"
Y_2018_file="Y_2018_file.txt"
Y_2019_file="Y_2019_file.txt"
Y_2020_file="Y_2020_file.txt"
Y_2021_file="Y_2021_file.txt"
Y_2022_file="Y_2022_file.txt"

# Currency
C_Bitcoin="hack{1,3,4,5,6,8,9,10,11,12,13,17,18,19,20,21,24,25,26,29}"
C_cash="hack43"
C_EOS="hack41"
C_Ethereum="hack44"
C_Multiple="hack{7,14,16,22,23,32,33,35,37,45,56}"
C_NEM="hack30"
C_Nano="hack31"
C_Vericoin="hack15"
C_Undisclosed="hack{28,34,49,40,42,48,49,51,53,54,55}"
C_Data"=hack{2,27,38,46,47,50,52}"

# Units stolen
U_A="hack{29,13,12}"      <4,999
U_B="hack{18,8,21,20,14,26,9}"    1,000-4,999
U_C="hack{11,19,17,6,4,5,3}" 5,000-49,999
U_D
U_E="hack{24,22,7,16,44,10}" 100,000-999,999
U_F="hack{15,31,43,37,30}" >5,000,000
U_G"=hack{1,23,25,28,32,33,34,35,36,39,40,41,42,45,48,49,51,53,54,55,56}" Undisclosed

# Value stolen
V_A="hack{29,51}"    <49,999
V_B="hack{13,45,4}"  50,000-99,999
V_C"=hack{23,3,6,18,49,5,21,7}"     100,000-499,999
V_D="hack{12,14,20}"     500,000-999,999
V_E="hack{9,25,19,15,22,37,42,11,26}"     1,000000-4,999,999
V_F="hack{17,48,56,1,16,41,34,33,43,32,44}"     5,000,000-49,999,999
V_G="hack{35,24,55,53}"     50,000,000-99,999,999
V_H="hack{40,54,31,30,10}"     >100,000,000
V_I="hack{1,23,25,28,32,33,34,35,36,39,40,41,42,43,45,48,49,51,53,54,55,56}" undisclosed


# Currency recovered
R_all="hack{51,13,5,12,14}" Yes
R_none="hack{1,3,4,6,7,8,9,10,11,15,16,17,18,19,20,21,22,23,24,25,26,29,30,31,32,33,34,35,37,40,41,42,43,44,45,48,49,53,54,55,56}" No
R_U="hack{28,36,39}" Undisclosed

# Hack exploit
E_A="hack{3,4,12,15,20,21,23,43,44,49,53,56}"     hot 
E_B="hack{11,17,19}"   cold 
E_C="hack{1,4}"       credentials
E_D="hack{18}"        internal error 
E_E="hack{41}"        internal theft 
E_F="hack{9}"         server vulnerability
E_G="hack{2,5,6,8,10,13,14,16,22,24,25,26,28,29,30,31,32,33,34,35,36,37,38,39,40,42,45,47,48,50,51,54,55}"    undisclosed 
E_H="hack{46,52}"     unsuccessful 


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
# The process would have proceeded using functions as follows                                        #
#                                                                                                    #
# Extracted data would be split into columns for each element:                                       #
# Hack #:Year:Exchange:Currency:Units:Value stolen:Value recovered:Hack type/vulnerability exploited #
# Elements would be outputted as arrays to $arrays.txt and used as inputs for subsequent script      #
# The arrays are presented below                                                                     #
#                                                                                                    # 
    hack1="1:2011:Mt Gox:Bitcoin:Undisclosed:8,750,000:0:Stolen credentials"                         # 
    hack2="2:2011:Bitcoin7:-:-:-:-:Data - Undisclosed"                                               # 
    hack3="3:2012:Bitcoinica:Bitcoin:43,554:228,000:0:Hot wallet"                                    # 
    hack4="4:2012:Bitcoinica:Bitcoin:38,000:87,000:0:Hot wallet"                                     # 
    hack5="5:2012:Bitcoinica:Bitcoin:40,000:300,000:300,000:Undisclosed"                             # 
    hack6="6:2012:Bitfloor:Bitcoin:24,000:250,000:0:Undisclosed"                                     # 
    hack7="7:2013:Vircurex:Various:250,117:352,000:0:Stolen credentials"                             # 
    hack8="8:2013:Picostocks:Bitcoin:1,300:Undisclosed:0:Undisclosed"                                # 
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

# Function creates arrays.txt from arrays $hack{1..56} inserts a delimiter "#" at the beginning of each variables
# "sed" commands 1-3 insert line breaks at "#" delimiters, deletes the blank top line then deletes the delimeter
# "sed" command 4 deletes the "," for calculation purposes

    function arrays() {

        var_a="arrays.txt"
        var_b="arrays_T.txt"

        echo -e \#$hack{1..56} > arrays.txt

            sed -i 's/#/\n&/g' $var_a

                sed -i '1d' $var_a

                    sed -i 's/#//g' $var_a

                        cat $var_a > "arrays_T.txt"

                            sed -i 's/,//g' $var_b
    } 

# Function removes the delimiters from the array in stages. Varaible "var_a" is formatted for display in tables, "var_b" is unformatted and used for calculations only

    function format_text() {

            sed -i 's/#/\n&/g' $var_a

                sed -i '1d' $var_a
    
                    sed -i 's/#//g' $var_a

                        cat $var_a > "$var_b"
                        
                            sed -i 's/,//g' $var_b
    }

# Function prints the data for the selected dataset as a formatted table

    function table_all_data() {
                      
        awk -F":" '

        BEGIN {
    
            printf ("_____________________________________________________________________________________________________________________\n");

            printf ("%-5s %-5s %-15s %-15s %-14s %-14s %-8s %-0s \n","| Hack","| Year","| Exchange","| Currency","| Units"," | \$ Value"," | \$ Recovered","| Vulnerability          |");
 
            printf ("_____________________________________________________________________________________________________________________\n");

        }

        {
        
        printf ("| %-4s | %-4s | %-13s | %-13s | %-13s | %-12s | %-11s | %-22s |\n", $1, $2, $3, $4, $5, $6, $7, $8 );

        printf ("_____________________________________________________________________________________________________________________\n")

        }' $var_a
    }

# Function prints the number of events listed in the table, supposed to add up the totals for each of columns 4 to 6

    function totals() {

        wc -l $var_a | awk '{print "Total hacks conducted: "$1}'
        awk '{ S+=$5 } END {print "Total units stolen: "S}' $var_b
        awk '{ S+=$6 } END {print "Total value stolen: $"S}' $var_b
        awk '{ S+=$7 } END {print "Total value recovered: $"S}' $var_b 
    }

# The following groups of functions creates a pair of .txt files for the selected parameters extracted from the arrays
# The functions include internal variables for referencing, and call the variables presented above
# When called the functions outputs the data as tables by referencing the previous functions, then deletes the .txt files

####################
# Years (column 2) #
####################

    function Y_2011() {

        year_a="$Y_2011_file"
        year_b="$Y_2011_T"

        echo -e \#$hack{1..2} > Y_2011_file.txt

        format_text 
        table_all_data 
        totals

        rm $Y_2011_file
        rm $Y_2011_T
    }

    function Y_2012() {

        year_a="$Y_2012_file"
        year_b="$Y_2012_T"    

        echo -e \#$hack{3..6} > Y_2012_file.txt

        format_text
        table_all_data 
        totals

        rm $Y_2012_file
        rm $Y_2012_T
    }
 
    function Y_2013() {

        year_a="$Y_2013_file"
        year_b="$Y_2013_T"  

        echo -e \#$hack{7..9} > Y_2013_file.txt

        format_text 
        table_all_data 
        totals

        rm $Y_2013_file
        rm $Y_2013_T
    }
    
    function Y_2014() {

        year_a="$Y_2014_file"
        year_b="$Y_2014_T"  

        echo -e \#$hack{10..16} > Y_2014_file.txt

        format_text 
        table_all_data 
        totals

        rm $Y_2014_file
        rm $Y_2014_T
    }
        
    function Y_2015() {

        year_a="$Y_2015_file"
        year_b="$Y_2015_T"  

        echo -e \#$hack{17..21} > Y_2015_file.txt

        format_text 
        table_all_data 
        totals

        rm $Y_2015_file
        rm $Y_2015_T
    }

    function Y_2016() {

        year_a="$Y_2016_file"
        year_b="$Y_2016_T"  

        echo -e \#$hack{22..25} > Y_2016_file.txt

        format_text 
        table_all_data 
        totals

        rm $Y_2016_file
        rm $Y_2016_T
    }        

    function Y_2017() {

        year_a="$Y_2017_file"
        year_b="$Y_2017_T"  

        echo -e \#$hack{26..28} > Y_2017_file.txt

        format_text
        table_all_data 
        totals

        rm $Y_2017_file
        rm $Y_2017_T
    }
    
    function Y_2018() {

        year_a="$Y_2018_file"
        year_b="$Y_2018_T"  

        echo -e \#$hack{29..36} > Y_2018_file.txt

        format_text 
        table_all_data 
        totals

        rm $Y_2018_file
        rm $Y_2018_T
    }
    
    function Y_2019() {

        year_a="$Y_2019_file"
        year_b="$Y_2019_T"  

        echo -e \#$hack{37..44} > Y_2019_file.txt

        format_text 
        table_all_data 
        totals

        rm $Y_2019_file
        rm $Y_2019_T
    }
    
    function Y_2020() {

        year_a="$Y_2020_file"
        year_b="$Y_2020_T"  

        echo -e \#$hack{45..50} > Y_2020_file.txt

        format_text 
        table_all_data 
        totals

        rm $Y_2020_file
        rm $Y_2020_T
    }
    
    function Y_2021() {

        year_a="$Y_2021_file"
        year_b="$Y_2021_T"  

        echo -e \#$hack{51..55} > Y_2021_file.txt

        format_text 
        table_all_data 
        totals

        rm $Y_2021_file
        rm $Y_2021_T
    }
    
    function Y_2022() {

        year_a="$Y_2022_file"
        year_b="$Y_2022_T"  

        echo -e \#$hack56 > Y_2022_file.txt

        format_text 
        table_all_data 
        totals

        rm $Y_2022_file
        rm $Y_2022_T
    }

##############################
# Currency stolen (column 4) #
##############################
    function C_Bitcoin() {

        var_a="C_Bitcoin.txt"
        var_b="C_Bitcoin_T.txt"

        echo -e \#$hack{1,3,4,5,6,8,9,10,11,12,13,17,18,19,20,21,24,25,26,29} > C_Bitcoin.txt

        format_text 
        table_all_data 
        totals

        rm "C_Bitcoin.txt"
        rm "C_Bitcoin_T.txt"
    }   

    function C_cash() {

        var_a="C_cash.txt"
        var_b="C_cash_T.txt"

        echo -e \#$hack43 > C_cash.txt

        format_text 
        table_all_data 
        totals

        rm "C_cash.txt"
        rm "C_cash_T.txt"
    }   

    function C_EOS() {

        var_a="C_EOS.txt"
        var_b="C_EOS_T.txt"

        echo -e \#$hack41 > C_EOS.txt

        format_text 
        table_all_data 
        totals

        rm "C_EOS.txt"
        rm "C_EOS_T.txt"
    }   

    function C_Ethereum() {

        var_a="C_Ethereum.txt"
        var_b="C_Ethereum_T.txt"

        echo -e \#$hack44 > C_Ethereum.txt

        format_text 
        table_all_data 
        totals

        rm "C_Ethereum.txt"
        rm "C_Ethereum_T.txt"
    } 

    function C_Multiple() {

        var_a="C_Multiple.txt"
        var_b="C_Multiple_T.txt"

        echo -e \#$hack{7,14,16,22,23,32,33,35,37,45,56} > C_Multiple.txt

        format_text 
        table_all_data 
        totals

        rm "C_Multiple.txt"
        rm "C_Multiple_T.txt"
    } 

    function C_NEM() {

        var_a="C_NEM.txt"
        var_b="C_NEM_T.txt"

        echo -e \#$hack30 > C_NEM.txt

        format_text 
        table_all_data 
        totals

        rm "C_NEM.txt"
        rm "C_NEM_T.txt"
    }
    
    function C_Nano() {

        var_a="C_Nano.txt"
        var_b="C_Nano_T.txt"

        echo -e \#$hack31 > C_Nano.txt

        format_text 
        table_all_data 
        totals

        rm "C_Nano.txt"
        rm "C_Nano_T.txt"
    }    

    function C_Vericoin() {

        var_a="C_Vericoin.txt"
        var_b="C_Vericoin_T.txt"

        echo -e \#$hack13 > C_Vericoin.txt

        format_text 
        table_all_data 
        totals

        rm "C_Vericoin.txt"
        rm "C_Vericoin_T.txt"
    }

    function C_Undisclosed() {

        var_a="C_Undisclosed.txt"
        var_b="C_Undisclosed_T.txt"

        echo -e \#$hack{28,34,49,40,42,48,49,51,53,54,55} > C_Undisclosed.txt

        format_text 
        table_all_data 
        totals

        rm "C_Undisclosed.txt"
        rm "C_Undisclosed.txt"
    }

    function C_Data() {

        var_a="C_Data.txt"
        var_b="C_Data_T.txt"

        echo -e \#$hack{2,27,38,46,47,50,52} > C_Data.txt

        format_text 
        table_all_data 
        totals

        rm "C_Data.txt"
        rm "C_Data_T.txt"
    }    


###########################
# Units stolen (column 5) #
###########################
    function U_A() {

        var_a="U_A.txt"
        var_b="U_A_T.txt"

        echo -e \#$hack{29,13,12} > U_A.txt

        format_text 
        table_all_data 
        totals

        rm "U_A.txt"
        rm "U_A.txt"
    } 

    function U_B() {

        var_a="U_B.txt"
        var_b="U_B_T.txt"

        echo -e \#$hack{18,8,21,20,14,26,9} > U_B.txt

        format_text 
        table_all_data 
        totals

        rm "U_B.txt"
        rm "U_B.txt"
    } 

    function U_C() {

        var_a="U_C.txt"
        var_b="U_C_T.txt"

        echo -e \#$hack{11,19,17,6,4,5,3} > U_C.txt

        format_text 
        table_all_data 
        totals

        rm "U_C.txt"
        rm "U_C_T.txt"
    } 

    function U_D() {

        echo -e None
    } 

    function U_E() {

        var_a="U_E.txt"
        var_b="U_E_T.txt"

        echo -e \#$hack{24,22,7,16,44,10} > U_E.txt

        format_text 
        table_all_data 
        totals

        rm "U_E.txt"
        rm "U_E_T.txt"
    } 

    function U_F() {

        var_a="U_F.txt"
        var_b="U_F_T.txt"

        echo -e \#$hack{15,31,43,37,30} > U_F.txt

        format_text 
        table_all_data 
        totals

        rm "U_F.txt"
        rm "U_F_T.txt"
    } 

    function U_G() {

        var_a="U_G.txt"
        var_b="U_G_T.txt"

        echo -e \#$hack{1,23,25,28,32,33,34,35,36,39,40,41,42,45,48,49,51,53,54,55,56} > U_G.txt

        format_text 
        table_all_data 
        totals

        rm "U_G.txt"
        rm "U_G_T.txt"
    } 

###########################
# Value stolen (column 6) #
###########################

    function V_A() {

        var_a="V_A.txt"
        var_b="V_A_T.txt"

        echo -e \#$hack{29,51} > V_A.txt

        format_text 
        table_all_data 
        totals

        rm "V_A.txt"
        rm "V_A.txt"
    } 

    function V_B() {

        var_a="V_B.txt"
        var_b="V_B_T.txt"

        echo -e \#$hack{13,45,4} > V_B.txt

        format_text 
        table_all_data 
        totals

        rm "V_B.txt"
        rm "V_B_T.txt"
    } 

    function V_C() {

        var_a="V_C.txt"
        var_b="V_C_T.txt"

        echo -e \#$hack{23,3,6,18,49,5,21,7} > V_C.txt

        format_text 
        table_all_data 
        totals

        rm "V_C.txt"
        rm "V_C_T.txt"
    } 

    function V_D() {

        var_a="V_D.txt"
        var_b="V_D_T.txt"

        echo -e \#$hack{12,14,20} > V_D.txt

        format_text 
        table_all_data 
        totals

        rm "V_D.txt"
        rm "V_D_T.txt"
    } 

    function V_E() {

        var_a="V_E.txt"
        var_b="V_E_T.txt"

        echo -e \#$hack{9,25,19,15,22,37,42,11,26} > V_E.txt

        format_text 
        table_all_data 
        totals

        rm "V_E.txt"
        rm "V_E_T.txt"
    } 

    function V_F() {

        var_a="V_F.txt"
        var_b="V_F_T.txt"

        echo -e \#$hack{17,48,56,1,16,41,34,33,43,32,44} > V_F.txt

        format_text 
        table_all_data 
        totals

        rm "V_F.txt"
        rm "V_F_T.txt"
    } 

    function V_G() {

        var_a="V_G.txt"
        var_b="V_G_T.txt"

        echo -e \#$hack{35,24,55,53} > V_G.txt

        format_text 
        table_all_data 
        totals

        rm "V_G.txt"
        rm "V_G_T.txt"
    } 

    function V_H() {

        var_a="V_H.txt"
        var_b="V_H_T.txt"

        echo -e \#$hack{40,54,31,30,10} > V_H.txt

        format_text 
        table_all_data 
        totals

        rm "V_H.txt"
        rm "V_H_T.txt"
    } 

    function V_I() {

        var_a="V_I.txt"
        var_b="V_I_T.txt"

        echo -e \#$hack{1,23,25,28,32,33,34,35,36,39,40,41,42,43,45,48,49,51,53,54,55,56} > V_I.txt

        format_text 
        table_all_data 
        totals

        rm "V_I.txt"
        rm "V_I_T.txt"
    } 

##############################
# Value recovered (column 7) #
##############################

    function R_all() {

        var_a="R_all.txt"
        var_b="R_all_T.txt"

        echo -e \#$hack{51,13,5,12,14} > R_all.txt

        format_text 
        table_all_data 
        totals

        rm "R_all.txt"
        rm "R_all_T.txt"
    }

    function R_none() {

        var_a="R_none.txt"
        var_b="R_none_T.txt"

        echo -e \#$hack{1,3,4,6,7,8,9,10,11,15,16,17,18,19,20,21,22,23,24,25,26,29,30,31,32,33,34,35,37,40,41,42,43,44,45,48,49,53,54,55,56} > R_none.txt

        format_text 
        table_all_data 
        totals

        rm "R_none.txt"
        rm "R_none_T.txt"
    }

    function R_U() {

        var_a="R_U.txt"
        var_b="R_U_T.txt"

        echo -e \#$hack{28,36,39} > R_U.txt

        format_text 
        table_all_data 
        totals

        rm "R_U.txt"
        rm "R_U_T.txt"
    }

###########################
# Hack exploit (column 8) #
###########################

    function E_A() {

        var_a="E_A.txt"
        var_b="E_A_T.txt"

        echo -e \#$hack{3,4,12,15,20,21,23,43,44,49,53,56} > E_A.txt

        format_text 
        table_all_data 
        totals

        rm "E_A.txt"
        rm "E_A_T.txt"
    }
    
    function E_B() {

    var_a="E_B.txt"
    var_b="E_B_T.txt"

    echo -e \#$hack{11,17,19} > E_B.txt

    format_text 
    table_all_data 
    totals

    rm "E_B.txt"
    rm "E_B_T.txt"

    }

    function E_C() {

    var_a="E_C.txt"
    var_b="E_C_T.txt"

    echo -e \#$hack{1,4} > E_C.txt

    format_text 
    table_all_data 
    totals

    rm "E_C.txt"
    rm "E_C_T.txt"

    }

    function E_D() {

    var_a="E_D.txt"
    var_b="E_D_T.txt"

    echo -e \#$hack18 > E_D.txt

    format_text 
    table_all_data 
    totals

    rm "E_D.txt"
    rm "E_D_T.txt"

    }

    function E_E() {

    var_a="E_E.txt"
    var_b="E_E_T.txt"

    echo -e \#$hack41 > E_E.txt

    format_text 
    table_all_data 
    totals

    rm "E_E.txt"
    rm "E_E_T.txt"

    }

    function E_F() {

    var_a="E_F.txt"
    var_b="E_F_T.txt"

    echo -e \#$hack9 > E_F.txt

    format_text 
    table_all_data 
    totals

    rm "E_F.txt"
    rm "E_F_T.txt"

    }

    function E_G() {

    var_a="E_G.txt"
    var_b="E_G_T.txt"

    echo -e \#$hack{2,5,6,8,10,13,14,16,22,24,25,26,28,29,30,31,32,33,34,35,36,37,38,39,40,42,45,47,48,50,51,54,55} > E_G.txt

    format_text 
    table_all_data 
    totals

    rm "E_G.txt"
    rm "E_G_T.txt"

    }

    function E_H() {

    var_a="E_H.txt"
    var_b="E_H_T.txt"

    echo -e \#$hack{46,52}  > E_H.txt

    format_text 
    table_all_data 
    totals

    rm "E_H.txt"
    rm "E_H_T.txt"

    }

###################################################################################################

###########################
# Security and Encryption #
###########################

# "Password_check" function checks the user's credentials against the password
# Password is encrypted and located in "Password/not_a_password.txt"

    function password_unlock() {

        read -sp "Database is locked. Please enter your password: " Pass_unlock

        Pass_unlock_hash=$(echo "$Pass_unlock" | sha256sum)
        Pass_lock="Password/not_a_password.txt"
        Pass_lock_hash=$(cat "$Pass_lock")

# If password is incorrect, script terminates

        if [ "$Pass_lock_hash" -ne "$Pass_unlock_hash" ]; then

            echo $red"Access Denied"$clear

            exit 1

# If password is correct, proceed to menu

        else

            echo $green'Access Granted.'$clear
            menu_main

        fi
    }

###################################################################################################

##################
# Menu functions #
##################

# The menu system is modular and works by calling the above functions through case statements
# "menu_main" is the top menu

    function menu_main() {
        
        echo $blue'Welcome to the Crypto Exchange Hacking Event Database.'
        echo 'It comprises a record of hacking events undertaken against crypocurrency exchanges between 2011 and 2022.'$clear
        echo
        echo $yellow'MAIN MENU'$clear
        echo
        echo $cyan'Please make a selection: '$clear
        read -p "
            1. Show all hacking event data
            2. Search by year
            3. Search by currency stolen
            4. Search by number of units stolen
            5. Search by value stolen
            6. Search by funds recovered
            7. Search by exploit type
            8. Exit
            " choice_menu_main

# Menu and sub-menu case statement options call specific functions

            case "$choice_menu_main" in

                1)
                    echo "1. Show all hacking event data"
                    menu_1 ;;
                2)
                    echo "2. Search by year"
                    menu_2 ;;
                3)
                    echo "3. Search by currency stolen"
                    menu_3 ;;
                4)
                    echo "4. Search by number of units stolen"
                    menu_4 ;;
                5)
                    echo "5. Search by value stolen"
                    menu_5 ;;
                6)
                    echo "6. Search by funds recovered"
                    menu_6 ;;
                7)
                    echo "7. Search by exploit type"
                    menu_7 ;;
                8)
                    echo "8. Exit"
                    menu_exit ;;
                *)
                    menu_error ;;
        
                esac
    }

    function menu_exit() {

        echo "Goodbye, thanks for visiting!"
        
        exit 0
    }

# "menu_error" function redirects user to "menu_main"

    function menu_error() {

        echo $red"That is not a valid response. Please select again..."$clear
        
        menu_main
        exit 1
        
    }

    function menu_1() {
        read -p "
            1. Show all data
            2. Back
            3. Exit
            " choice_menu_1

        case "$choice_menu_1" in

            1)
                arrays
                table_all_data    
                totals
                format_text
                rm "arrays.txt"
                rm "arrays_T.txt"
                menu_1 ;;
            2)
                menu_main ;;
            3)
                menu_exit ;;
            *)
                menu_error ;;
    })
        esac


    function menu_2() {
        read -p "
            1. Select a year
            2. Back
            3. Exit
            " choice_menu_2
            case "$choice_menu_1" in

                1)
                    # Call menu_2_1 function
                    menu_2_1 ;;
                2)
                    menu_2 ;;
                3)
                    menu_exit ;;
                *)
                    menu_error ;;
    }
    )       esac

    function menu_2_1() {
        read -p "
            1. 2011
            2. 2012
            3. 2013
            4. 2014
            5. 2015
            6. 2016
            7, 2017
            8. 2018
            9. 2019
            10. 2020
            11. 2021
            12. 2022
            13. Back
            14. Exit
            " choice_menu_2_1

            case "$choice_menu_2_1" in
                # Call "year" function
                1)
                    Y_2011 ;;
                2)
                    Y_2012 ;;
                3)
                    Y_2013 ;;
                4)
                    Y_2014 ;;
                5)
                    Y_2015 ;;
                6)
                    Y_2016 ;;
                7)
                    Y_2017 ;;
                8)
                    Y_2018 ;;
                9)
                    Y_2019;;
                10)
                    Y_2020 ;;
                11)
                    Y_2021 ;;
                12)
                    Y_2022 ;;
                13)
                    menu_2 ;;
                14)
                    menu_exit
                *)
                    menu_error ;;



    function menu_3() {


    }

    function menu_4() {


    }


    function menu_5() {


    }

    function menu_6() {


    }


    function menu_7() {


    }


#########################
# MENUS

# Main menu                                     # $menu_main
    # OPTIONS
        # 1. Show all hacking event data        # $menu_1
            # 1.1 Show all data                 # function menu_1_1_all_data()
            # 1.2 Back                          # $menu_main
            # 1.3 Exit                          # $exit
        # 2. Search by year                     # $menu_2
                # 2.1 2011                      # $menu_2_1
                    # 2.1.1 Summary             # $Y_2011
                    # 2.1.2 Back                # $menu_2
                    # 2.1.3 Exit                # $exit
                # 2.2 2012                      # $menu_2_2
                    # 2.2.1 Summary             > $Y_2012
                    # 2.2.2 Back                > $menu_2
                    # 2.2.2 Exit                > $exit
                # 2.3 2013                      > $menu_2_3
                    # 2.3.1 Summary             > $Y_2013
                    # 2.3.2 Back                > $menu_2
                    # 2.3.3 Exit                > $exit
                # 2.4 2014                      > $menu_2_4
                    # 2.4.1 Summary             > $Y_2014
                    # 2.4.2 Back                > $menu_2
                    # 2.4.3 Exit                > $exit            
                # 2.5 2015                      > $menu_2_5
                    # 2.5.1 Summary             > $Y_2015
                    # 2.5.2 Back                > $menu_2
                    # 2.5.3 Exit                > $exit
                # 2.6 2016                      > $menu_2_6
                    # 2.6.1 Summary             > $Y_2016
                    # 2.6.2 Back                > $menu_2
                    # 2.6.3 Exit                > $exit                
                # 2.7 2017                      > $menu_2_7
                    # 2.7.1 Summary             > $Y_2017
                    # 2.7.2 Back                > $menu_2
                    # 2.7.3 Exit                > $exit
                # 2.8 2018                      > $menu_2_8
                    # 2.8.1 Summary             > $Y_2018
                    # 2.8.2 Back                > $menu_2
                    # 2.8.3 Exit                > $exit
                # 2.9 2019                      > $menu_2_9
                    # 2.9.1 Summary             > $Y_2019
                    # 2.9.2 Back                > $menu_2
                    # 2.9.3 Exit                > $exit
                # 2.10 2020                     > $menu_2_10
                    # 2.10.1 Summary            > $Y_2020
                    # 2.10.2 Back               > $menu_2
                    # 2.10.3 Exit               > $exit
                # 2.11 2021                     > $menu_2_11
                    # 2.11.1 Summary            > $Y_2021
                    # 2.11.2 Back               > $menu_2
                    # 2.11.3 Exit               > $exit
                # 2.12 2022                     > $menu_2_12
                    # 2.12.1 Summary            > $Y_2022
                    # 2.12.2 Back               > $menu_2
                    # 2.12.3 Exit               > $exit
                # 2.13 Back                     > $menu_main
                # 2.14 Exit                     > $exit

        # 3. Search by currency stolen          > $menu_3
            # 3.1 Bitcoin                       > $menu_3_1
                # 3.1.1 Summary                 > $C_Bitcoin
                # 3.1.2 Back                    > $menu_3
                # 3.1.3 exit                    > $exit
            # 3.2 EOS                           > $menu_3_2
                # 3.2.1 Summary                 > $C_EOS
                # 3.2.2 Back                    > $menu_3
                # 3.2.3 Exit                    > $exit
            # 3.3 Ethereum                      > $menu_3_3
                # 3.3.1 Summary                 > $C_Ethereum
                # 3.3.2 Back                    > $menu_3
                # 3.3.3 Exit                    > $exit
            # 3.4 NEM                           > $menu_3_4
                # 3.4.1 Summary                 > $C_NEM
                # 3.4.2 Back                    > $menu_3
                # 3.4.3 Exit                    > $exit
            # 3.5 Nano                          > $menu_3_5
                # 3.5.1 Summary                 > $C_Nano
                # 3.5.2 Back                    > $menu_3
                # 3.5.3 Exit                    > $exit
            # 3.6 Vericoin                      > $menu_3_6
                # 3.6.1 Summary                 > $C_Verizon
                # 3.6.2 Back                    > $menu_3
                # 3.6.3 Exit                    > $exit
            # 3.7 Multiple currencies           > $menu_3_7
                # 3.7.1 Summary                 > $C_multiple
                # 3.7.2 Back                    > $menu_3
                # 3.7.3 Exit                    > $exit
            # 3.8 Undisclosed                   > $menu_3_8
                # 3.8.1 Summary                 > $C_undisclosed
                # 3.8.2 Back                    > $menu_3
                # 3.8.3 Exit                    > $exit
            # 3.9 Cash only                     > $menu_3_9
                # 3.9.1 Summary                 > $C_cash
                # 3.9.2 Back                    > $menu_3
                # 3.9.3 Exit                    > $exit
            # 3.10 Data only                    > $menu_3_10
                # 3.10.1 Summary                > $Data
                # 3.10.2 Back                   > $menu_3
                # 3.10.3 Exit                   > $exit
            # 3.11 Back                         > $menu_main
            # 3.12 Exit                         > $exit
        
        # 4. Search by number of units stolen   > $menu_4
            # 4.1 <100                          > $menu_4_1
                # 4.1.1 Summary                 > $U_0-99
                # 4.1.2 Back                    > $menu_4
                # 4.1.3 Exit                    > $exit
            # 4.2 100 - 999                     > $menu_4_2
                # 4.2.1 Summary                 > $U_100-999
                # 4.2.2 Back                    > $menu_4
                # 4.2.3 Exit                    > $exit
            # 4.3 1,000 - 9,999                 > $menu_4_3
                # 4.3.1 Summary                 > $U_1000-9999
                # 4.3.2 Back                    > $menu_4
                # 4.3.3 Exit                    > $exit    
            # 4.4 10,000 - 99,999               > $menu_4_4
                # 4.4.1 Summary                 > $U_10000-99999
                # 4.4.2 Back                    > $menu_4
                # 4.4.3 Exit                    > $exit
            # 4.5 100,000 - 999,999             > $menu_4_5
                # 4.5.1 Summary                 > $U_100000-999999
                # 4.5.2 Back                    > $menu_4
                # 4.5.3 Exit                    > $exit
            # 4.6 1,000,000 - 9,999,999         > $menu_4_6
                # 4.6.1 Summary                 > $U_1000000-9999999
                # 4.6.2 Back                    > $menu_4
                # 4.6.3 Exit                    > $exit
            # 4.7 10,000,000 - 99,999,999       > $menu_4_7
                # 4.7.1 Summary                 > $U_10000000-99999999
                # 4.7.2 Back                    > $menu_4
                # 4.7.3 Exit                    > $exit
            # 4.8 > 100,000,000                 > $menu_4_8
                # 4.8.1 Summary                 > $U_>100000000
                # 4.8.2 Back                    > $menu_4
                # 4.8.3 Exit                    > $exit
            # 4.9 Undisclosed                   > $menu_4_9
                # 4.9.1 Summary                 > $U_undisclosed
                # 4.9.2 Back                    > $menu_4
                # 4.9.3 Exit                    > $exit

        # 5. Search by value stolen             > $menu_5
            # 5.1 <$50,000                      > $menu_5_1
                # 5.1.1 Summary                 > $V_49999
                # 5.1.2 Back                    > $menu_5
                # 5.1.3 Exit                    > $exit
            # 5.2 $50,000 - $99,999             > $menu_5_2
                # 5.2.1 Summary                 > $V_50000-99999
                # 5.2.2 Back                    > $menu_5
                # 5.2.3 Exit                    > $exit
            # 5.3 $100,000 - $499,999           > $menu_5_3
                # 5.3.1 Summary                 > $V_100000-499999
                # 5.3.2 Back                    > $menu_5
                # 5.3.3 Exit                    > $exit
            # 5.4 $500,000 - $999,999           > $menu_5_4
                # 5.4.1 Summary                 > $V_500000-999999
                # 5.4.2 Back                    > $menu_5
                # 5.4.3 Exit                    > $exit
            # 5.5 $1,000,000 - $4,999,999       > $menu_5_5
                # 5.5.1 Summary                 > $V_1000000-4999999
                # 5.5.2 Back                    > $menu_5
                # 5.5.3 Exit                    > $exit   
            # 5.6 $5,000,000 - $9,999,999       > $menu_5_6
                # 5.6.1 Summary                 > $V_5000000-9999999
                # 5.6.2 Back                    > $menu_5
                # 5.6.3 Exit                    > $exit
            # 5.7 $10,000,000 - $49,999,999     > $menu_5_7
                # 5.7.1 Summary                 > $V_10000000-49999999
                # 5.7.2 Back                    > $menu_5
                # 5.7.3 Exit                    > $exit
            # 5.8 $50,000,000 - $99,999,999     > $menu_5_8
                # 5.8.1 Summary                 > $V_50000000-99999999
                # 5.8.2 Back                    > $menu_5
                # 5.8.3 Exit                    > $exit
            # 5.9 > $100,000,000                > $menu_5_9
                # 5.9.1 Summary                 > $V_>100000000
                # 5.9.2 Back                    > $menu_5
                # 5.9.3 Exit                    > $exit
            # 5.10 Back                         > $menu_main
            # 5.11 Exit                         > $exit
         
        # 6. Search by funds recovered          > $menu_6
            # 6.1 Yes                           > $menu_6_1
                # 6.1.1 Summary                 > $R_all
                # 6.1.2 Back                    > $menu_6
                # 6.1.3 Exit                    > $exit
            # 6.2 No                            > $menu_6_2
                # 6.2.1 Summary                 > $R_none
                # 6.2.2 Back                    > $menu_6
                # 6.2.3 Exit                    > $exit
            # 6.3 Undisclosed                   > $menu_6_3
                # 6.3.1 Summary                 > $R_undisclosed
                # 6.3.2 Back                    > $menu_6
                # 6.3.3 Exit                    > $exit
            # 6.4 Back                          > $menu_main
            # 6.5 Exit                          > $exit

        # 7. Search by exploit                  > $menu_7
            # 7.1 Hot wallet                    > $menu_7_1
                # 7.1.1 Summary                 > $E_hot
                # 7.1.2 Back                    > $menu_7
                # 7.1.3 Exit                    > $exit
            # 7.2 Cold wallet                   > $menu_7_2
                # 7.2.1 Summary                 > $E_cold
                # 7.2.2 Back                    > $menu_7
                # 7.2.3 Exit                    > $exit     
            # 7.3 Credential theft              > $menu_7_3
                # 7.3.1 Summary                 > $E_credentials
                # 7.3.2 Back                    > $menu_7
                # 7.3.3 Exit                    > $exit
            # 7.4 Internal error                > $menu_7_4
                # 7.4.1 Summary                 > $E_error
                # 7.4.2 Back                    > $menu_7
                # 7.4.3 Exit                    > $exit
            # 7.5 Internal theft                > $menu_7_5
                # 7.5.1 Summary                 > $E_internal
                # 7.5.2 Back                    > $menu_7
                # 7.5.3 Exit                    > $exit
            # 7.6 Server error                  > $menu_7_6
                # 7.6.1 Summary                 > $E_server
                # 7.6.2 Back                    > $menu_7
                # 7.7.3 Exit                    > $exit
            # 7.7 Undisclosed                   > $menu_7_7
                # 7.7.1 Summary                 > $E_undisclosed
                # 7.7.2 Back                    > $menu_7
                # 7.7.3 Exit                    > $exit
            # 7.8 Unsuccessful                  > $menu_7_8
                # 7.8.1 Summary                 > $E_unsuccessful
                # 7.8.2 Back                    > $menu_7
                # 7.8.3 Exit                    > $exit
            # 7.9 Back                          > $menu_main
            # 7.10 Exit                         > $exit

        # 8. Exit                               > $exit


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
# https://towardsdatascience.com/how-to-create-a-foolproof-interactive-terminal-menu-with-bash-scripts-97911586d4e5

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