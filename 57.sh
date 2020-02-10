#!/bin/bash
#
#program:
#    在每月第一天备份并压缩/etc目录的所有内容，存放在/root/bak目录里，且文件名为如下形式"yymmdd_etc.tar.gz"，yy为年，mm为月，dd为日。
#
#history:
#2020/02/10    kun    V1.0

d1=`date +%d`

if [ $d1 == "01" ]
then
    cd /etc/
    [ ! -d /root/bak ] && mkdir /root/bak
    tar zcf /root/bak/`date +%Y%m%d`_etc.tar.gz ./
fi
