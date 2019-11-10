#!/bin/bash
#
#program:
#    判断参数是否是目录
#
#history:
#2019/11/10    kun    V1.0

if [ $# -eq 0 ];then
    ls .
else
    for d in $@;do
        if [ -d $d ];then
            echo "$d 有下面的子目录"
            find $d -type d
        else
            echo "$d 并不是目录"
        fi
    done
fi

