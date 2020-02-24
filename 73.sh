#!/bin/bash
#
#program:
#    依次向/etc/passwd中的每个用户问好
#
#history:
#2020/02/24    kun    V1.0

cat /etc/passwd |while read line
do
    username=`echo $line |awk -F ':' '{print $1}'`
    uid=`echo $line |awk -F ':' '{print $3}'`
    echo "Hello, $username,your UID is $uid."
done
