#!/bin/bash
#
#program:
#    计算数字个数
#
#history:
#2019/09/18    kun    V1.0

sum=0

while read i
do
    n=$(echo "$i"|sed 's/[^0-9]//g'|wc -L)
    echo $n
    sum=$[$sum+$n]
done < $1
echo "sum:$sum"
