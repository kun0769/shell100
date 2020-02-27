#!/bin/bash
#
#program:
#    用两种方法，批量把当前目录下面所有文件名后缀为.bak的后缀去掉，例如1.txt.bak去掉后为1.txt
#
#history:
#2020/02/27    kun    V1.0

for i in `ls -d ./*bak`
do
    #使用sed去掉
    mv $i `echo $i|sed 's/\.bak$//'`
    #使用awk把.bak做分隔符去掉后面字符
    f=`echo $i|awk -F '.bak$' '{print $1}'`
    mv $i $f
done
