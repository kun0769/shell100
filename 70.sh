#!/bin/bash
#
#program:
#    实现简易计算器功能
#
#history:
#2020/02/21    kun    V1.0

judge_number()
{
    num=`echo $1|sed "s/[0-9.]//g"`
    [ -n "$num" ] && echo "$1 is not number.Please input number." && exit
    if echo $1 |grep -q "^\."
    then
        echo "$1 is illegal number!" && exit
    fi
}

math()
{
    case $2 in
        +)
        echo "$1+$3"|bc
        ;;
        -)
        n=`echo "$1-$3"|bc`
        #判断计算后的数是否是负数
        if echo $n|grep -q "^-"
        then
            #判断计算后的数第二位是否是.
            if echo $n|cut -c2|grep -q "^\."
            then
                n1=`echo $n|cut -c1`
                echo -n "$n1"
                echo -n "0"
                echo "$n"|cut -c2-
            else
                echo $n
            fi
        else
            #判断计算后的数开头是否是.
            if echo $n|grep -q "^\."
            then
                echo "0$n"
            else
                echo $n
            fi
        fi
        ;;
        x)
        echo "$1*$3"|bc
        ;;
        /)
        echo "scale=2;$1/$3"|bc
        ;;
        *)
        echo "$2 must to + - x /"
        ;;
    esac
}

if [ $# -eq 3 ]
then
    judge_number $1
    judge_number $3
    math $1 $2 $3
else
    echo "Please input 3 args!" && exit
fi
