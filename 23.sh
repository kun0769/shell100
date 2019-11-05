#!/bin/bash
#
#program:
#    检测网卡流量
#
#history:
#2019/09/20    kun    V1.0

logdir=/tmp/log
logfile=$(date +%Y%m%d).log

export LANG=C
[ -d logdir ] || mkdir -p $logdir

exec >> $logdir/$logfile
date +"%F %H:%M"
sar -n DEV 1 2|grep ens33|grep Average|awk '{print "eth0 input:"$5*8000"bps\neth0 output:"$6*8000"bps"}'
echo "#################"
