#!/bin/bash
#
#program:
#    比较两个数的大小，支持浮点数，两个数通过shell参数的形式提供。
#
#history:
#2020/02/11    kun    V1.0

if [ $# -ne 2 ]
then
    echo "Please input two number"
    exit
fi

judge_number()
{
    #负数的去掉-
    if echo $1 |grep -q "^-"
    then
        nu=`echo $1 |sed s/^-//g`
    else
        nu=$1
    fi
    n=`echo $nu |sed 's/[0-9.]//g'`
    [ -n "$n" ] && echo "$1 is not number" && exit
    #判断是.开头的
    if echo $1 |grep -q "^\."
    then
        echo "$1 is not number" && exit
    fi
}

judge_number $1
judge_number $2

if [ "$1" == "$2" ]
then
    echo "$1 = $2"
else
    num=`echo "$1>$2" |bc`
    #值为1表示$1>$2 0表示$1<$2
    if [ $num -eq 1 ]
    then
        echo "$1 > $2"
    else
        echo "$1 < $2"
    fi
fi
