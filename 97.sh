#!/bin/bash
#
#program:
#    打印一个三角形（正三角形，元素用*表示）
#
#history:
#2020/03/17    kun    V1.0

while :
do
    read -p "请输入一个数字: " num
    if [ -z "$num" ]
    then
        echo "请输入一个数字..."
        continue
    fi
    n=`echo $num|sed s/[0-9]//g`
    if [ -n "$n" ]
    then
        echo "请输入一个纯数字..."
        continue
    else
        break
    fi
done

for i in `seq 1 $num`
do
    # j表示当前行的空格得个数
    j=$[$num-$i]
    for m in `seq 1 $j`
    do
        echo -n " "
    done
    for p in `seq 1 $i`
    do
        echo -n "* "
    done
    echo
done
