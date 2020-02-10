#!/bin/bash
#
#program:
#    将文件内所有的单词的重复次数计算出来，只需要列出重复次数最多的10个单词
#
#history:
#2020/02/10    kun    V1.0

for w in `sed 's/[^a-zA-Z]/ /g' $1`
do 
    echo $w
done |sort |uniq -c |sort -nr |head
