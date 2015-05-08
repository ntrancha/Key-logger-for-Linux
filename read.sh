#!/bin/sh

delais=2

old=0
k_ctrl=0
k_alt=0
k_shift=0
phrase=""

while read line
do
	time=`echo "$line" | awk '{print $1}'`
	key=`echo "$line" | awk '{print $2}'`
	add1=`echo "$line" | awk '{print $4}'`   #left ctrl
	add3=`echo "$line" | awk '{print $6}'`   #right shift
	add5=`echo "$line" | awk '{print $8}'`   #left alt
	add7=`echo "$line" | awk '{print $10}'`  #left shift
	add9=`echo "$line" | awk '{print $12}'`  #right ctrl
	add11=`echo "$line" | awk '{print $14}'` #right alt
	test_lc=`echo "$add1" | grep "True" | wc -l`
	test_rc=`echo "$add9" | grep "True" | wc -l`
	test_rs=`echo "$add3" | grep "True" | wc -l`
	test_ls=`echo "$add7" | grep "True" | wc -l`
	test_la=`echo "$add5" | grep "True" | wc -l`
	test_ra=`echo "$add11" | grep "True" | wc -l`
    time0=`echo "$time" | cut -d . -f 1`
    add0="${add1}${add3}${add5}${add7}${add9}${add11}"
    old0=`echo $(($old+3))`
    date0=`echo "@${time0}"`
    date1=`date -d $date0 `
    date=`date +%s`
    if [ $old0 -lt $time0 ]
	then
		echo $phrase
		echo $date1
		phrase=""
	fi
    if [ $test_lc -eq 1 ] || [ $test_rc -eq 1 ]
    then
		if [ $k_ctrl -eq 0 ]
		then
			k_ctrl=1
            key="<ctrl down>"
		fi
	else
		if [ $k_ctrl -eq 1 ]
		then
			key="<ctrl up>"
		fi
		k_ctrl=0
    fi
    if [ $test_la -eq 1 ] || [ $test_ra -eq 1 ]
    then
		if [ $k_alt -eq 0 ]
		then
			k_alt=1
            key="<alt down>"
		fi
	else
		if [ $k_alt -eq 1 ]
		then
			key="<alt up>"
		fi
		k_alt=0
    fi
    if [ $test_ls -eq 1 ] || [ $test_rs -eq 1 ]
    then
		if [ $k_shift -eq 0 ]
		then
			k_shift=1
            key="<shift down>"
		fi
	else
		if [ $k_shift -eq 1 ]
		then
			key="<shift up>"
		fi
		k_shift=0
    fi
    key=`echo "$key" | cut -d \' -f 2`
	phrase=`echo "${phrase}${key}"`
    old=$time0
done < /var/log/keylogger.txt
echo $phrase
