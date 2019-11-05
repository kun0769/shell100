#!/bin/bash
#
#program:
#    计算100以内所有能被3整除的正整数的和
#
#history:
#2019/09/22    kun    V1.0

sum=0
for i in `seq 1 100`
do
    j=$[$i%3]
    if [ $j -eq 0 ];then
        sum=$[$sum+$i]
    fi
done
echo $sum
