#!/bin/bash
#
#program:
#   写一个shell脚本，通过curl -I 返回的状态码来判定所访问的网站是否正常。 比如，当状态码为200时，才算正常
#
#history:
#2020/02/09    kun    V1.0

curl="www.baidu.com"
mail_user=aaa@163.com

code=`curl -I $curl 2>/tmp/51.err|head -1|awk '{print $2}'`
if [ -z "code" ];then
    python mail.py $mail_user "$url访问异常" "`cat /tmp/51.err`"
    exit
elif [ $code != "200" ];then
    curl -I $curl &>/tmp/51.log
    python mail.py $mail_user "$url访问异常 状态码$code" "`cat /tmp/51.log`"
else
    echo "$curl访问正常"
fi

