#!/bin/bash
#
#program:
#    检测新文件
#
#history:
#2019/09/18    kun    V1.0

d=$(date +%Y%m%d%H%M)
dir=/data/web/attachment
list=/tmp/file_list.txt

find $dir -type d -mmin -5 > $list

n=$(wc -l $list)

[ $n -nq 0 ] && mv $list /tmp/$d.txt
