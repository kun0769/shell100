#!/bin/bash
#
#program:
#    统计文件的大小
#
#history:
#2019/09/18    kun    V1.0

d=$(date +%H)
d1=$(date +%d%H)
filedir=/tmp/log
targetdir=/data/log

[ -d $filedir ] || mkdir $filedir

if [ "$d" == "00" ] || [ "$d" == "12" ]
then
    for i in $(find $targetdir/ -type f);do
        > $i
    done
else
    for i in $(find $targetdir/ -type f);do
        du -sh $filedir > $filedir/d1.log
    done
fi
