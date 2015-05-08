#!/bin/sh

while [ 1 -eq 1 ]
do
	./read.sh > result.txt
	sleep 1
	clear
	tail -n 20 result.txt
done
