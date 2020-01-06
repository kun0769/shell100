#!/bin/bash
#
#program:
#    写一个猜数字脚本，当用户输入的数字和预设数字（随机生成一个0-100的数字）一样时，直接退出，
#    否则让用户一直输入，并且提示用户的数字比预设数字大或者小
#
#history:
#2020/01/06    kun    V1.0

num=$[$RANDOM%101]

while :
do
    read -p "请输入一个(0-100)的数字:" n
    n1=`echo $n|sed s/[0-9]//g` 
    if [ -n "$n1" ];then
        echo "请输入数字!"
	continue
    fi
    if [ $n -gt $num ];then
	echo "你输入的数字大了!"
	continue
    elif [ $n -lt $num ];then
	echo "你输入的数字小了!"
	continue
    else
	echo "恭喜你，答对了!"
	break
    fi
done
