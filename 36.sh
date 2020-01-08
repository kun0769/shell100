#!/bin/bash
#
#program:
#    用shell实现，把一个文本文档中只有一个数字的行给打印出来
#
#history:
#2020/01/09    kun    V1.0

while read line
do
    n=`echo $line|sed s/[^0-9]//g|wc -L`
    if [ $n -eq 1 ];then
	echo $line
    fi
done < /tmp/test.log
