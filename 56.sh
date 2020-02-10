#!/bin/bash
#
#program:
#    在文本文档1.txt第5行（假设文件行数大于5）后面增加内容
#
#history:
#2020/02/10    kun    V1.0

n=0

cat 1.txt|while read line
do
    n=$[$n+1]
    if [ $n -eq 5 ]
    then
        echo $n
        echo -e "# This is a test file.\n# Test insert line into this file."
    else
        echo $n
    fi
done
