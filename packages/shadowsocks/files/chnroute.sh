#!/bin/sh

rm chnroute.txt
wget -4 -O- http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest > apnic.txt
cat apnic.txt| awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > chnroute.txt
rm apnic.txt
