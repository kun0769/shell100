#!/bin/bash
#
#program:
#    有两个文件a.txt和b.txt，需求是，把a.txt中有的但b.txt中没有的行发现来，并写入到c.txt，然后计算c.txt文件的行数。
#
#history:
#2020/02/11    kun    V1.0

cat a.txt |while read line
do
    if ! grep -q "$line" b.txt
    then
        echo $line
    fi
done >> c.txt
wc -l c.txt
