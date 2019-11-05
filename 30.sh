#!/bin/bash
#
#program:
#    判断字符是否是纯数字
#
#history:
#2019/09/22    kun    V1.0

while :
do
    read -p "请输入数字：" n
    if echo $n |grep -qi "end";then
        exit
    fi
    n1=`echo $n |sed s/[0-9]//g`
    [ -n "$n1" ] && echo "请输入一个纯数字..." || echo "你输入的数字是：$n"
done
