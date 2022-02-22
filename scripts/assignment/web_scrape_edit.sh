#!/bin/bash

# Assessment 4: web scraping 


# assign curl variable

curl=$(which curl)
outfile="output.txt"
tabledata="table.txt"
regex="<p>$1"
#searchterm=$(echo $1 | tr ' ' '+')
url="https://www.hedgewithcrypto.com/cryptocurrency-exchange-hacks/"

# Dump webpage
  
function dump_webpage() {
    $curl -o $outfile $url &>/dev/null
    check_errors
}

function check_errors() {
    [ $? -ne 0 ] && echo "\033[31mThere was an error downloading this page...\033[0m" && exit -1
} 

# Remove HTML code

function format_html() {
	#    sed -i '/<h3>.*&#8211;.*<\/h3>/,$!d' $outfile
	#    sed -i '/482180/q' $outfile
	#    sed -i '/<h3>.*<\/h3>/,$!d' $outfile
	#    sed -i '/<h3>.*\\d{4}<\/h3>/,$!d' $outfile
        
        sed -i 's/&#x27;/ /g' $outfile
      
        sed -n '/87,000/p' $outfile
  
        grep ".*" $outfile | sed -n '/[<h3><li>]/ {
	        s/<[^>]*>//g
	        s/&#8211;/-/g
	        s/|/-/g
	        s/&#8217;//g
	        p
	    }' > temp.txt
	   
	    sed -i 1,10d temp.txt 
        sed -n -i '/87,000/' temp.txt
}



  

#####################################
#             Main script           #
#####################################

dump_webpage
format_html


#https://www.youtube.com/watch?v=DZ0WKRmUTm4 

