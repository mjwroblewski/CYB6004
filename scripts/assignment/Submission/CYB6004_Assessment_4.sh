#!/bin/bash

# CYB6004: Assessment 4

# Created by Michael Wroblewski
# Date created - 2022/02/21
# Date last modified - 2022/03/07

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
#Pass_unlock_hash="$(echo "$Pass_unlock" | sha256sum)"
#Pass_lock="Password/not_a_password.txt"
#Pass_lock_hash="$(cat "$Pass_lock")"

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
C_Data="hack{2,27,38,46,47,50,52}"

# Units stolen
U_A="hack{29,13,12}"
U_B="hack{18,8,21,20,14,26,9}"
U_C="hack{11,19,17,6,4,5,3}"
U_D="hack{24,22,7,16,44,10}"
U_E="hack{15,31,43,37,30}"
U_F="hack{1,23,25,28,32,33,34,35,36,39,40,41,42,45,48,49,51,53,54,55,56}"

# Value stolen
V_A="hack{29,51}"
V_B="hack{13,45,4}"
V_C="hack{23,3,6,18,49,5,21,7}"
V_D="hack{12,14,20}"
V_E="hack{9,25,19,15,22,37,42,11,26}"
V_F="hack{17,48,56,1,16,41,34,33,43,32,44}"
V_G="hack{35,24,55,53}"
V_H="hack{40,54,31,30,10}"
V_I="hack{1,23,25,28,32,33,34,35,36,39,41,42,43,45,48,49,51,53,54,55,56}"

# Currency recovered
R_all="hack{51,13,5,12,14}"
R_none="hack{1,3,4,6,7,8,9,10,11,15,16,17,18,19,20,21,22,23,24,25,26,29,30,31,32,33,34,35,37,40,41,42,43,44,45,48,49,53,54,55,56}"
R_U="hack{28,36,39}"

# Hack exploit
E_A="hack{3,4,12,15,20,21,23,43,44,49,53,56}"
E_B="hack{11,17,19}"
E_C="hack{1,7}"
E_D="hack18"
E_E="hack41" 
E_F="hack9"
E_G="hack{2,5,6,8,10,13,14,16,22,24,25,26,28,29,30,31,32,33,34,35,36,37,38,39,40,42,45,47,48,50,51,54,55}" 
E_H="hack{46,52}" 


#############
# FUNCTIONS #
#############

# Web scraping

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


    dump_webpage
    remove_html
    formatting


######################################################################################################
# NOTE: The next step was to extract hacking event data from $formatfile                                              
# Despite best efforts this was not achieved within the timeframe                                    
# The process would have proceeded using functions as follows                                        
#                                                                                                    
# Extracted data would be split into columns for each element:                                       
# Hack #:Year:Exchange:Currency:Units:Value stolen:Value recovered:Hack type/vulnerability exploited 
# Elements would be outputted as arrays to $arrays.txt and used as inputs for subsequent script      
# The arrays are presented below                                                                     
                                                                                                     
    hack1="1:2011:Mt Gox:Bitcoin:Undisclosed:8,750,000:0:Stolen credentials"                          
    hack2="2:2011:Bitcoin7:-:-:-:-:Data - Undisclosed"                                                
    hack3="3:2012:Bitcoinica:Bitcoin:43,554:228,000:0:Hot wallet"                                     
    hack4="4:2012:Bitcoinica:Bitcoin:38,000:87,000:0:Hot wallet"                                      
    hack5="5:2012:Bitcoinica:Bitcoin:40,000:300,000:300,000:Undisclosed"                              
    hack6="6:2012:Bitfloor:Bitcoin:24,000:250,000:0:Undisclosed"                                      
    hack7="7:2013:Vircurex:Various:250,117:352,000:0:Stolen credentials"                              
    hack8="8:2013:Picostocks:Bitcoin:1,300:Undisclosed:0:Undisclosed"                                 
    hack9="9:2013:Inputs.io:Bitcoin:4,100:1,200,000:0:Server vulnerability"                           
    hack10="10:2014:Mt Gox:Bitcoin:844,408:661,348,000:0:Undisclosed"                                 
    hack11="11:2014:Picostocks:Bitcoin:5,896:4,434,000:0:Cold wallet"                                 
    hack12="12:2014:Flexcoin:Bitcoin:896:600,000:600,000:Hot wallet"                                  
    hack13="13:2014:Poloniex:Bitcoin:97:67,500:67,500:Undisclosed"                                   
    hack14="14:2014:Crypto Rush:Various:3,450:630,000:630,000:Undisclosed"                           
    hack15="15:2014:MintPal:Vericoin:8,000,000:1,933,000:0:Hot wallet"                               
    hack16="16:2014:Cryptysy:Various:313,000:9,580,000:0:Undisclosed"                                
    hack17="17:2015:Bitstamp:Bitcoin:19,000:5,100,000:0:Cold wallet"                                  
    hack18="18:2015:796:Bitcoin:1,000:270,000:0:Internal error"                                      
    hack19="19:2015:BTER:Bitcoin:7,170:1,750,000:0:Cold wallet"                                      
    hack20="20:2015:KipCoin:Bitcoin:3,000:728,000:0:Hot wallet"                                      
    hack21="21:2015:Bitfinex:Bitcoin:1,400:329,000:0:Hot wallet"                                     
    hack22="22:2016:Gatecoin:Various:185,250:2,140,000:0:Undisclosed"                                
    hack23="23:2016:ShapeShift:Various:Undisclosed:200,000:0:Hot wallet"                             
    hack24="24:2016:Bitfinex:Bitcoin:120,000:72,000,000:0:Undisclosed"                               
    hack25="25:2016:Bitcurex:Bitcoin:Undisclosed:1,500,000:0:Undisclosed"                            
    hack26="26:2017:Yapizon:Bitcoin:3,831:4,850,000:0:Undisclosed"                                   
    hack27="27:2017:Bithumb:-:-:-:-:Data - Undisclosed"                                              
    hack28="28:2017:YouBit:Undisclosed:Undisclosed:Undisclosed:Undisclosed:Undisclosed"              
    hack29="29:2018:LocalBitcoins:Bitcoin:7.9:27,000:0:Undisclosed"                                   
    hack30="30:2018:Coincheck:NEM:500,000,000:500,000,000:0:Undisclosed"                             
    hack31="31:2018:BitGrail:Nano:17,000,000:170,000,000:0:Undisclosed"                              
    hack32="32:2018:Coinrail:Various:Undisclosed:40,000,000:0:Undisclosed"                           
    hack33="33:2018:Bithumb:Various:Undisclosed:31,000,000:0:Undisclosed"                            
    hack34="34:2018:Bancor:Undisclosed:Undisclosed:23,000,000:0:Undisclosed"                         
    hack35="35:2018:Zaif:Various:Undisclosed:60,000,000:0:Undisclosed"                               
    hack36="36:2018:MapleChange:Undisclosed:Undisclosed:Undisclosed:Undisclosed:Undisclosed"         
    hack37="37:2019:Cryptopia:Various:48,019,391:3,620,000:0:Undisclosed"                             
    hack38="38:2019:Coinmama:-:-:-:-:Data - Undisclosed"                                             
    hack39="39:2019:DragonEX:Undisclosed:Undisclosed:Undisclosed:Undisclosed:Undisclosed"            
    hack40="40:2019:Coinbene:Undisclosed:Undisclosed:100,000,000:0:Undisclosed"                      
    hack41="41:2019:Bithumb:EOS:Undisclosed:13,000,000:0:Internal theft"                             
    hack42="42:2019:Bitrue:Undisclosed:Undisclosed:4,200,000:0:Undisclosed"                          
    hack43="43:2019:BITPoint:Cash:32,000,000:32,000,000:0:Hot wallet"                                
    hack44="44:2019:Upbit:Ethereum:342,000:49,000,000:0:Hot wallet"                                  
    hack45="45:2020:Altsbit:Various:Undisclosed:73,000:0:Undisclosed"                                 
    hack46="46:2020:BlockFi:-:-:-:-:Unsuccessful"                                                    
    hack47="47:2020:BuyUcoin:-:-:-:-:Data - Undisclosed"                                             
    hack48="48:2020:Eterbase:Undisclosed:Undisclosed:5,400,000:0:Undisclosed"                        
    hack49="49:2020:KuCoin:Undisclosed:Undisclosed:280,000:0:Hot wallet key theft"                   
    hack50="50:2020:Livecoin:-:-:-:-:Undisclosed"                                                    
    hack51="51:2021:Cryptopia:Undisclosed:Undisclosed:45,000:45,000:Undisclosed"                      
    hack52="52:2021:Hotbit:-:-:-:-:Unsuccessful"                                                     
    hack53="53:2021:Liquid:Undisclosed:Undisclosed:80,000,000:0:Hot wallet"                          
    hack54="54:2021:BitMart:Undisclosed:Undisclosed:150,000,000:0:Undisclosed"                       
    hack55="55:2021:AscendEX:Undisclosed:Undisclosed:78,000,000:0:Undisclosed"                       
    hack56="56:2022:LCX:Various:Undisclosed:6,800,000:0:Hot wallet"                                   
                                                                                                     
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


# Function prints the number of events listed in the table, supposed to add up the totals for each of columns 4 to 6

    function totals() {

        echo
        wc -l $var_a | awk '{print "Total hacks conducted: "$1}'
        awk '{ S+=$5 } END {print "Total units stolen: "S}' $var_b
        awk '{ S+=$6 } END {print "Total value stolen: $"S}' $var_b
        awk '{ S+=$7 } END {print "Total value recovered: $"S}' $var_b 
    }


# Function prints the data for the selected dataset as a formatted table
# Executes the "totals" function

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

        totals
    }


# The following groups of functions creates a pair of .txt files for the selected parameters extracted from the arrays
# The functions include internal variables for referencing, and call the variables presented above
# When called the functions outputs the data as tables by referencing the previous functions, then deletes the .txt files

####################
# Years (column 2) #
####################

    function Y_2011() {

        var_a="Y_2011_file.txt"
        var_b="Y_2011_T.txt"

        echo -e \#$hack{1..2} > Y_2011_file.txt

        format_text 
        table_all_data 
        
        rm "Y_2011_file.txt"
        rm "Y_2011_T.txt"
    }

    function Y_2012() {

        var_a="Y_2012_file.txt"
        var_b="Y_2012_T.txt"    

        echo -e \#$hack{3..6} > Y_2012_file.txt

        format_text
        table_all_data 

        rm "Y_2012_file.txt"
        rm "Y_2012_T.txt"
    }
 
    function Y_2013() {

        var_a="Y_2013_file.txt"
        var_b="Y_2013_T.txt"  

        echo -e \#$hack{7..9} > Y_2013_file.txt

        format_text 
        table_all_data 

        rm "Y_2013_file.txt"
        rm "Y_2013_T.txt"
    }
    
    function Y_2014() {

        var_a="Y_2014_file.txt"
        var_b="Y_2014_T.txt"  

        echo -e \#$hack{10..16} > Y_2014_file.txt

        format_text 
        table_all_data 

        rm "Y_2014_file.txt"
        rm "Y_2014_T.txt"
    }
        
    function Y_2015() {

        var_a="Y_2015_file.txt"
        var_b="Y_2015_T.txt"  

        echo -e \#$hack{17..21} > Y_2015_file.txt

        format_text 
        table_all_data 

        rm "Y_2015_file.txt"
        rm "Y_2015_T.txt"
    }

    function Y_2016() {

        var_a="Y_2016_file.txt"
        var_b="Y_2016_T.txt"  

        echo -e \#$hack{22..25} > Y_2016_file.txt

        format_text 
        table_all_data 

        rm "Y_2016_file.txt"
        rm "Y_2016_T.txt"
    }        

    function Y_2017() {

        var_a="Y_2017_file.txt"
        var_b="Y_2017_T.txt"  

        echo -e \#$hack{26..28} > Y_2017_file.txt

        format_text
        table_all_data 

        rm "Y_2017_file.txt"
        rm "Y_2017_T.txt"
    }
    
    function Y_2018() {

        var_a="Y_2018_file.txt"
        var_b="Y_2018_T.txt"  

        echo -e \#$hack{29..36} > Y_2018_file.txt

        format_text 
        table_all_data 

        rm "Y_2018_file.txt"
        rm "Y_2018_T.txt"
    }
    
    function Y_2019() {

        var_a="Y_2019_file.txt"
        var_b="Y_2019_T.txt"  

        echo -e \#$hack{37..44} > Y_2019_file.txt

        format_text 
        table_all_data 

        rm "Y_2019_file.txt"
        rm "Y_2019_T.txt"
    }
    
    function Y_2020() {

        var_a="Y_2020_file.txt"
        var_b="Y_2020_T.txt"  

        echo -e \#$hack{45..50} > Y_2020_file.txt

        format_text 
        table_all_data 

        rm "Y_2020_file.txt"
        rm "Y_2020_T.txt"
    }
    
    function Y_2021() {

        var_a="Y_2021_file.txt"
        var_b="Y_2021_T.txt"  

        echo -e \#$hack{51..55} > Y_2021_file.txt

        format_text 
        table_all_data 

        rm "Y_2021_file.txt"
        rm "Y_2021_T.txt"
    }
    
    function Y_2022() {

        var_a="Y_2022_file.txt"
        var_b="Y_2022_T.txt"  

        echo -e \#$hack56 > Y_2022_file.txt

        format_text 
        table_all_data 

        rm "Y_2022_file.txt"
        rm "Y_2022_T.txt"
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
        
        rm "C_Bitcoin.txt"
        rm "C_Bitcoin_T.txt"
    }   

    function C_cash() {

        var_a="C_cash.txt"
        var_b="C_cash_T.txt"

        echo -e \#$hack43 > C_cash.txt

        format_text 
        table_all_data 
        
        rm "C_cash.txt"
        rm "C_cash_T.txt"
    }   

    function C_EOS() {

        var_a="C_EOS.txt"
        var_b="C_EOS_T.txt"

        echo -e \#$hack41 > C_EOS.txt

        format_text 
        table_all_data 
        
        rm "C_EOS.txt"
        rm "C_EOS_T.txt"
    }   

    function C_Ethereum() {

        var_a="C_Ethereum.txt"
        var_b="C_Ethereum_T.txt"

        echo -e \#$hack44 > C_Ethereum.txt

        format_text 
        table_all_data 
        
        rm "C_Ethereum.txt"
        rm "C_Ethereum_T.txt"
    } 

    function C_Multiple() {

        var_a="C_Multiple.txt"
        var_b="C_Multiple_T.txt"

        echo -e \#$hack{7,14,16,22,23,32,33,35,37,45,56} > C_Multiple.txt

        format_text 
        table_all_data 
        
        rm "C_Multiple.txt"
        rm "C_Multiple_T.txt"
    } 

    function C_NEM() {

        var_a="C_NEM.txt"
        var_b="C_NEM_T.txt"

        echo -e \#$hack30 > C_NEM.txt

        format_text 
        table_all_data 
        
        rm "C_NEM.txt"
        rm "C_NEM_T.txt"
    }
    
    function C_Nano() {

        var_a="C_Nano.txt"
        var_b="C_Nano_T.txt"

        echo -e \#$hack31 > C_Nano.txt

        format_text 
        table_all_data 
        
        rm "C_Nano.txt"
        rm "C_Nano_T.txt"
    }    

    function C_Vericoin() {

        var_a="C_Vericoin.txt"
        var_b="C_Vericoin_T.txt"

        echo -e \#$hack15 > C_Vericoin.txt

        format_text 
        table_all_data 
        
        rm "C_Vericoin.txt"
        rm "C_Vericoin_T.txt"
    }

    function C_Undisclosed() {

        var_a="C_Undisclosed.txt"
        var_b="C_Undisclosed_T.txt"

        echo -e \#$hack{28,34,49,40,42,48,49,51,53,54,55} > C_Undisclosed.txt

        format_text 
        table_all_data 
        
        rm "C_Undisclosed.txt"
        rm "C_Undisclosed_T.txt"
    }

    function C_Data() {

        var_a="C_Data.txt"
        var_b="C_Data_T.txt"

        echo -e \#$hack{2,27,38,46,47,50,52} > C_Data.txt

        format_text 
        table_all_data 
        
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
        
        rm "U_A.txt"
        rm "U_A_T.txt"
    } 

    function U_B() {

        var_a="U_B.txt"
        var_b="U_B_T.txt"

        echo -e \#$hack{18,8,21,20,14,26,9} > U_B.txt

        format_text 
        table_all_data 
        
        rm "U_B.txt"
        rm "U_B_T.txt"
    } 

    function U_C() {

        var_a="U_C.txt"
        var_b="U_C_T.txt"

        echo -e \#$hack{11,19,17,6,4,5,3} > U_C.txt

        format_text 
        table_all_data 
        
        rm "U_C.txt"
        rm "U_C_T.txt"
    } 

    function U_D() {

        var_a="U_D.txt"
        var_b="U_D_T.txt"

        echo -e \#$hack{24,22,7,16,44,10} > U_D.txt

        format_text 
        table_all_data 
        
        rm "U_D.txt"
        rm "U_D_T.txt"
    } 

    function U_E() {

        var_a="U_E.txt"
        var_b="U_E_T.txt"

        echo -e \#$hack{15,31,43,37,30} > U_E.txt

        format_text 
        table_all_data 
        
        rm "U_E.txt"
        rm "U_E_T.txt"
    } 

    function U_F() {

        var_a="U_F.txt"
        var_b="U_F_T.txt"

        echo -e \#$hack{1,23,25,28,32,33,34,35,36,39,40,41,42,45,48,49,51,53,54,55,56} > U_F.txt

        format_text 
        table_all_data 
        
        rm "U_F.txt"
        rm "U_F_T.txt"
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
        
        rm "V_A.txt"
        rm "V_A_T.txt"
    } 

    function V_B() {

        var_a="V_B.txt"
        var_b="V_B_T.txt"

        echo -e \#$hack{13,45,4} > V_B.txt

        format_text 
        table_all_data 
        
        rm "V_B.txt"
        rm "V_B_T.txt"
    } 

    function V_C() {

        var_a="V_C.txt"
        var_b="V_C_T.txt"

        echo -e \#$hack{23,3,6,18,49,5,21,7} > V_C.txt

        format_text 
        table_all_data 
        
        rm "V_C.txt"
        rm "V_C_T.txt"
    } 

    function V_D() {

        var_a="V_D.txt"
        var_b="V_D_T.txt"

        echo -e \#$hack{12,14,20} > V_D.txt

        format_text 
        table_all_data 
        
        rm "V_D.txt"
        rm "V_D_T.txt"
    } 

    function V_E() {

        var_a="V_E.txt"
        var_b="V_E_T.txt"

        echo -e \#$hack{9,25,19,15,22,37,42,11,26} > V_E.txt

        format_text 
        table_all_data 
        
        rm "V_E.txt"
        rm "V_E_T.txt"
    } 

    function V_F() {

        var_a="V_F.txt"
        var_b="V_F_T.txt"

        echo -e \#$hack{17,48,56,1,16,41,34,33,43,32,44} > V_F.txt

        format_text 
        table_all_data 
        
        rm "V_F.txt"
        rm "V_F_T.txt"
    } 

    function V_G() {

        var_a="V_G.txt"
        var_b="V_G_T.txt"

        echo -e \#$hack{35,24,55,53} > V_G.txt

        format_text 
        table_all_data 
        
        rm "V_G.txt"
        rm "V_G_T.txt"
    } 

    function V_H() {

        var_a="V_H.txt"
        var_b="V_H_T.txt"

        echo -e \#$hack{40,54,31,30,10} > V_H.txt

        format_text 
        table_all_data 
        
        rm "V_H.txt"
        rm "V_H_T.txt"
    } 

    function V_I() {

        var_a="V_I.txt"
        var_b="V_I_T.txt"

        echo -e \#$hack{1,23,25,28,32,33,34,35,36,39,40,41,42,43,45,48,49,51,53,54,55,56} > V_I.txt

        format_text 
        table_all_data 
        
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
        
        rm "R_all.txt"
        rm "R_all_T.txt"
    }

    function R_none() {

        var_a="R_none.txt"
        var_b="R_none_T.txt"

        echo -e \#$hack{1,3,4,6,7,8,9,10,11,15,16,17,18,19,20,21,22,23,24,25,26,29,30,31,32,33,34,35,37,40,41,42,43,44,45,48,49,53,54,55,56} > R_none.txt

        format_text 
        table_all_data 
        
        rm "R_none.txt"
        rm "R_none_T.txt"
    }

    function R_U() {

        var_a="R_U.txt"
        var_b="R_U_T.txt"

        echo -e \#$hack{28,36,39} > R_U.txt

        format_text 
        table_all_data 
        
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
        
        rm "E_A.txt"
        rm "E_A_T.txt"
    }
    
    function E_B() {

        var_a="E_B.txt"
        var_b="E_B_T.txt"

        echo -e \#$hack{11,17,19} > E_B.txt

        format_text 
        table_all_data 
        
        rm "E_B.txt"
        rm "E_B_T.txt"
    }

    function E_C() {

        var_a="E_C.txt"
        var_b="E_C_T.txt"

        echo -e \#$hack{1,4} > E_C.txt

        format_text 
        table_all_data 
        
        rm "E_C.txt"
        rm "E_C_T.txt"
    }

    function E_D() {

        var_a="E_D.txt"
        var_b="E_D_T.txt"

        echo -e \#$hack18 > E_D.txt

        format_text 
        table_all_data 
        
        rm "E_D.txt"
        rm "E_D_T.txt"
    }

    function E_E() {

        var_a="E_E.txt"
        var_b="E_E_T.txt"

        echo -e \#$hack41 > E_E.txt

        format_text 
        table_all_data 
        
        rm "E_E.txt"
        rm "E_E_T.txt"
    }

    function E_F() {

        var_a="E_F.txt"
        var_b="E_F_T.txt"

        echo -e \#$hack9 > E_F.txt

        format_text 
        table_all_data 
        
        rm "E_F.txt"
        rm "E_F_T.txt"
    }

    function E_G() {

        var_a="E_G.txt"
        var_b="E_G_T.txt"

        echo -e \#$hack{2,5,6,8,10,13,14,16,22,24,25,26,28,29,30,31,32,33,34,35,36,37,38,39,40,42,45,47,48,50,51,54,55} > E_G.txt

        format_text 
        table_all_data 
        
        rm "E_G.txt"
        rm "E_G_T.txt"
    }

    function E_H() {

        var_a="E_H.txt"
        var_b="E_H_T.txt"

        echo -e \#$hack{46,52}  > E_H.txt

        format_text 
        table_all_data 
        
        rm "E_H.txt"
        rm "E_H_T.txt"
    }

###################################################################################################

##################
# Menu functions #
##################

# The menu system is modular and works by calling the above functions through case statements
# "menu_main" is the top menu

    function menu_intro() {
        echo
        echo 'Welcome to the Crypto Exchange Hacking Event Database.'
        echo
        echo 'It comprises a record of hacking events undertaken against crypocurrency exchanges between 2011 and 2022.'$clear
        echo
    }

    function menu_main() {
        echo
        echo '   MAIN MENU'
        echo
        echo '   Please make a selection: '
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
        echo
        echo "Goodbye, thanks for visiting!"
        
        rm dump.txt
        rm strip.txt
        rm format.txt
        rm arrays.txt
        rm arrays_T.txt

        exit 0
    }

# "menu_error" function redirects user to "menu_main"

    function menu_error() {
        echo
        echo "That is not a valid response. Please select again..."
        
        menu_main
        exit 1
    }

    function menu_1() {
        echo
        echo '   Please make a selection: '
        read -p "
            1. Show all data
            2. Back
            3. Exit
            " choice_menu_1

        case "$choice_menu_1" in
            1)
                arrays
                table_all_data    
                format_text
                                
                menu_main ;;
            2)
                menu_main ;;
            3)
                menu_exit ;;
            *)
                menu_error ;;
        esac
    }

    function menu_2() {
        echo
        echo '   Please make a selection: '
        read -p "
            1. Select a year
            2. Back
            3. Exit
            " choice_menu_2_1
            case "$choice_menu_2_1" in
                1)
                    menu_2_1 ;;
                2)
                    menu_main ;;
                3)
                    menu_exit ;;
                *)
                    menu_error ;;
           esac
    }

    function menu_2_1() {
        echo
        echo '   Please make a selection: '
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
                # Call "year" functions
                1)
                    Y_2011
                    menu_2_1 ;;
                2)
                    Y_2012
                    menu_2_1 ;;
                3)
                    Y_2013
                    menu_2_1 ;;
                4)
                    Y_2014
                    menu_2_1 ;;
                5)
                    Y_2015
                    menu_2_1 ;;
                6)
                    Y_2016
                    menu_2_1 ;;
                7)
                    Y_2017
                    menu_2_1 ;;
                8)
                    Y_2018
                    menu_2_1 ;;
                9)
                    Y_2019
                    menu_2_1 ;;
                10)
                    Y_2020
                    menu_2_1 ;;
                11)
                    Y_2021
                    menu_2_1 ;;
                12)
                    Y_2022
                    menu_2_1 ;;
                13)
                    menu_main ;;
                14)
                    menu_exit ;;
                *)
                    menu_error ;;
            esac
    }

    function menu_3() {
        echo
        echo '   Please make a selection: '
        read -p "
        1. Bitcoin
        2. EOS
        3. Ethereum
        4. NEM
        5. Nano
        6. Vericoin
        7. Multiple currencies
        8. Undisclosed
        9. Cash only
        10. Data only
        11. Back
        12. Exit
        " choice_menu_3_1

            case "$choice_menu_3_1" in
                # call "currency" functions
                1)
                    C_Bitcoin
                    menu_3 ;;
                2)
                    C_EOS
                    menu_3 ;;
                3)
                    C_Ethereum
                    menu_3 ;;
                4)
                    C_NEM
                    menu_3 ;;
                5)
                    C_Nano
                    menu_3 ;;
                6)
                    C_Vericoin
                    menu_3 ;;
                7)
                    C_Multiple
                    menu_3 ;;
                8)
                   C_Undisclosed
                   menu_3 ;;
                9)
                    C_cash
                    menu_3 ;;
                10) 
                    C_Data
                    menu_3 ;;
                11)
                    menu_main ;;
                12)
                    menu_exit ;;
                *)
                    menu_error ;;
            esac
    }

    function menu_4() {
        echo
        echo '   Please make a selection: '
        read -p "
        1. < 1,000
        2. 1,000 - 4,999
        3. 5,000 - 49,999
        4. 100,000 - 999,999
        5. > 8,000,000
        6. Undisclosed
        7. Back
        8. Exit
        " choice_menu_4_1

            case "$choice_menu_4_1" in
            # call "units stolen" functions
            1)
                U_A
                menu_4 ;;
            2)
                U_B
                menu_4 ;;
            3)
                U_C
                menu_4 ;;
            4)
                U_D
                menu_4 ;;
            5)
                U_E
                menu_4 ;;
            6)
                U_F
                menu_4 ;;
            7)
                menu_main ;;
            8)
                menu_exit ;;
            *)
                menu_error ;;
            esac
    }

    function menu_5() {
        echo
        echo '   Please make a selection: '
        read -p "
        1. < \$50,000
        2. \$50,000 - \$99,999
        3. \$100,000 - \$499,999
        4. \$500,000 - \$999,999
        5. \$1,000,000 - \$4,999,999
        6. \$5,000,000 - \$49,999,999
        7. \$50,000,000 - \$99,999,999
        8. > \$100,000,000
        9. Undisclosed
        10. Back
        11. Exit
        " choice_menu_5_1

            case "$choice_menu_5_1" in
            # Call "value stolen" functions
            1)
                V_A
                menu_5 ;;
            2)
                V_B
                menu_5 ;;
            3)
                V_C
                menu_5 ;;
            4)
                V_D
                menu_5 ;;
            5)
                V_E
                menu_5 ;;
            6)
                V_F
                menu_5 ;;
            7)
                V_G
                menu_5 ;;
            8)
                V_H
                menu_5 ;;
            9)
                V_I
                menu_5 ;;
            10)
                menu_main ;;
            11)
                menu_exit ;;
            *)
                menu_error ;;
            esac
    }

    function menu_6() {
        echo
        echo '   Please make a selection: '
        read -p "
        1. Currency recovered
        2. No currency recovered
        3. Undisclosed
        4. Back
        5. Exit
        " choice_menu_6_1

            case "$choice_menu_6_1" in
            # Call "currency recovered" functions
            1)
                R_all
                menu_6 ;;
            2)
                R_none
                menu_6 ;;
            3)
                R_U
                menu_6 ;;
            4)
                menu_main ;;
            5)
                menu_exit ;;
            *)
                menu_error ;;
            esac
    }

    function menu_7() {
        echo
        echo '   Please make a selection: '
        read -p "
        1. Hot wallet
        2. Cold wallet
        3. Credentials
        4. Internal error
        5. Internal theft
        6. Server vulnerability
        7. Undisclosed
        8. Unsuccessful
        9. Back
        10. Exit
        " choice_menu_7_1

            case "$choice_menu_7_1" in
            # Call "exploits" functions
            1)
                E_A
                menu_7 ;;
            2)
                E_B
                menu_7 ;;
            3)
                E_C
                menu_7 ;;
            4)
                E_D
                menu_7 ;;
            5)
                E_E
                menu_7 ;;
            6)
                E_F
                menu_7 ;;
            7)
                E_G
                menu_7 ;;
            8)
                E_H
                menu_7 ;;
            9)
                menu_main ;;
            10)
                menu_exit ;;
            *)
                menu_error ;;
            esac
    }

##################
# Code execution #
##################

arrays
menu_intro
menu_main



# REFERENCES

# https://cryptosec.info/exchange-hacks/
# https://stackoverflow.com/questions/9907200/how-to-minify-obfuscate-a-bash-script
# https://www.appsealing.com/code-obfuscation/
# https://www.youtube.com/watch?v=sa-TUpSx1JA 
# https://www.youtube.com/watch?v=fCw-xf31M_s 
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
# https://infoheap.com/awk-sum-examples/ 
# https://www.unix.com/unix-for-dummies-questions-and-answers/222767-file-row-line-count-without-header-footer.html 

# CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
#    Week 2: Creating user interaction scripts
#        2.2 Writing more interactive scripts
#        2.4 Write if statements to control program flow
#    Week 3 - Snippets and repetition
#        3.3 Using loops for repetition
#    Week 5: Regular expressions and text manipulation
#        5.5 Understand and execute scripts that use AWK

#################
# END OF SCRIPT #
#################