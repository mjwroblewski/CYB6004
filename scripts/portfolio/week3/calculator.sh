#!/bin/bash

# Calculator highlights the answer in a colour specific to the selected operator.
# Michael - 2022/02/06

echo "I am your basic calculator!"

echo -e "I can add, subtract, multiply, and divide.\n"

    read -p "Enter your first number: " numOne

    read -p "Enter your second number: " numTwo

    echo "Please select an operation:"

        echo -e "\033[34m 1. Addition \e[0m"
        echo -e "\033[32m 2. Subtraction \e[0m"
        echo -e "\033[31m 3. Multiplication \e[0m"
        echo -e "\033[35m 4. Division \e[0m"
    read operator

case $operator in
1)
    res=`echo "scale=0; $numOne+$numTwo" | bc`
        echo -e "\033[34m"$numOne plus $numTwo equals $res"\e[0m"
    ;;
2)
    res=`echo "scale=0; $numOne-$numTwo" | bc`
        echo -e "\033[32m"$numOne less $numTwo equals $res"\e[0m"
    ;;
3)
    res=`echo "scale=0; $numOne*$numTwo" | bc`
        echo -e "\033[31m"$numOne multiplied by $numTwo equals $res"\e[0m"
    ;;
4)
    res=`echo "scale=2; $numOne/$numTwo" | bc`
        echo -e "\033[35m"$numOne divided by $numTwo equals $res"\e[0m"
    ;;
*)
    echo "Invalid selection"
;;
esac

exit 0

# References
    # CYB6004.2022.AC1.OFFCAMPUS Scripting Languages
        # Week 3 - Snippets and repetition
        # 3.2 Use arithmetic expressions to do calculations in scripts
    # https://stackoverflow.com/questions/37052899/what-is-the-preferred-method-to-echo-a-blank-line-in-a-shell-script
    # https://www.tutorialsandyou.com/bash-shell-scripting/bash-bc-18.html
    # https://askubuntu.com/questions/831971/what-type-of-sequences-are-escape-sequences-starting-with-033