#!/bin/bash
#
#program:
#    输入一串随机字符串，然后按照千分位输出
#    例子：输入的字符串"123456789",输出为"123,456,789"
#
#history:
#2020/01/11    kun    V1.0

n=`echo $1|wc -L`
for i in `echo $1|sed 's/./& /g'`;do
    #n1表示当前位置,被3整除就在前加, 再通过$[$n-1]来遍历下一位
    n1=$[$n%3]
    if [ $n1 -eq 0 ];then
        echo -n ",$i"
    else
        echo -n "$i"
    fi
    n=$[$n-1]
done|sed 's/^,//' #除去开头的,
echo  #用于换行
