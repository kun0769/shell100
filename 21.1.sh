#!/bin/bash
#
#program:
#    计算数字个数
#
#history:
#2019/09/18    kun    V1.0

sum=0

for i in $(seq 1 `wc -l $1 |awk '{print $1}'`)
do 
    a=$(sed -n "$(echo $i)p" $1)
    n=$(echo "$a"|sed 's/[^0-9]//g'|wc -L)
    echo $n
    sum=$[$sum+$n]
done
echo "sum:$sum"
