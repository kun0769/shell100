#!/bin/bash
#
#program:
#    计算数字的规律
#
#history:
#2019/09/16    kun    V1.0

x=10
y=21

for i in $(seq 0 15);do
    echo $x
    x=$[$x+$y]
    z=$[2**$i]
    y=$[$y+$z]
done
