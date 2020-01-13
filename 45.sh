#!/bin/bash
#
#program:
#    把文本里面每三行内容合并到一行输出
#
#history:
#2020/01/13    kun    V1.0

n=1
cat $1|while read line
do
    n1=$[$n%3]
    if [ $n1 -eq 0 ];then
	echo "$line"
    else
	echo -n "$line "
    fi
    n=$[$n+1]
done
echo
