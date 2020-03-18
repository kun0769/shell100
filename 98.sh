#!/bin/bash
#
#program:
#    截取出字符
#
#history:
#2020/03/18    kun    V1.0

var=http://www.aaa.com/root/123.htm 


echo $var|grep -o "www.*"
echo $var|awk -F'//' '{print $2}'

echo $var|awk -F'/' '{print $NF}'
echo $var|grep -o "[0-9]*\.htm"

echo $var|grep -o "http.*root"
echo $var|sed "s#/123.htm##g"

echo $var|awk -F '//' '{print $1}'
echo $var|sed "s#//.*##g"

echo $var|awk -F 'www' '{print $1}'
echo $var|sed "s#www.*##g"

echo $var|awk -F '/' '{print $4"/"$5}'
echo $var|sed "s#^.*.com/##g"

echo $var|grep -o "[0-9]*"
echo $var|sed "s#[^0-9]##g"

