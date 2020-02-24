#!/bin/bash
#
#program:
#    打印正方形
#
#history:
#2020/02/24    kun    V1.0

while :
do
    read -p "Please input a number: " n
    n1=`echo $n |sed "s/[0-9]//g"`
    if [ -n "$n1" ]
    then
        echo "$n is not number."
        continue
    else
        break
    fi
done

for i in `seq 1 $n`
do
    for j in `seq 1 $n`
    do
        echo -n "■ "
    done
    echo
done
