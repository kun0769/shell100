#!/bin/bash
#
#program:
#    判断文件是否存在并计算单词个数
#
#history:
#2020/02/21    kun    V1.0

if [ $# -ne 2 ]
then
    echo "请输入两个参数，第一个参数为目录名字，第二个参数为单词"
    exit
fi

cd $1/
for f in `ls ./`
do
    if [ -d $f ]
    then
        if [ -f $f/test.txt ]
        then
            n=`grep -cw "$2" $f/test.txt`
            echo "$1/$f目录下有test.txt文件，该文件下有$n个$2."
        fi
    fi
done
