#!/bin/bash
#
#program:
#    封ip和解封ip
#
#history:
#2019/09/16    kun    V1.0

block_ip(){
    d1=$(date -d "-1min" +%Y:%H:%M)
    logfile=/date/logs/access_log
    
    egrep "$d1:[0-9]+" $logfile > /tmp/tmp_last_min.log
    awk '{print $1}' /tmp/tmp_last_min.log |sort -n |uniq -c |sort -n |awk 'if $1>100 {print $2}'>/tmp/bad_ip.list
    n=$(wc -l /tmp/bad_ip.list |awk '{print $1}')
    if [ $n -nq 0 ];then
        for ip in $(cat /tmp/bad_ip.list);do
            iptables -I INPUT -s $ip -j REJECT
        done
    fi
}

unblock_ip(){
    iptables -nvL INPUT| sed '1d'| awk '$1<5 {print $8}' > /tmp/good_ip.list
    n=$(wc -l /tmp/bad_ip.list |awk '{print $1}')
    if [ $n -ne 0 ];then
        for ip in $(cat /tmp/good_ip.list);do
            iptables -D INPUT -s $ip -j REJECT
        done
    fi
    iptables -Z
}

t=$(date +%M)
if [ "$t" == "00" ]||["$t" == "30" ];then
    unblock_ip
    block_ip
else
    block_ip 
fi
