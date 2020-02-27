#!/bin/bash    
#    
#program:    
#    查询指定域名的过期时间，并在到期前一周，每天发一封提醒邮件。
#    
#history:    
#2020/02/27    kun    V1.0  

mail_u=admin@admin.com
#当前日期时间戳，用于和域名的到期时间做比较
t1=`date +%s`

#检测whois命令是否存在，不存在则安装jwhois包
is_install_whois()
{
    which whois >/dev/null 2>/dev/null
    if [ $? -ne 0 ]
    then
        yum install -y epel-release
        yum install -y jwhois
    fi
}

notify()
{
    #根据不同过期关键字来获得日期
    if whois $1 |grep -q "Expiry Date"
    then
        e_d=`whois $1|grep "Expiry Date"|awk '{print $4}'|cut -d 'T' -f 1`
    elif whois $1 |grep -q "Expiration Time"
    then
        e_d=`whois $1|grep "Expiration Time"|awk '{print $3}'`
    elif whois $1 |grep -q "Expiration Date"
    then
        e_d=`whois $1|grep "Expiration Date"|tail -1 |awk '{print $5}' |awk -F 'T' '{print $1}'`
    fi
    
    #将域名过期的日期转化为时间戳
    e_t=`date -d "$e_d" +%s`
    #计算一周一共有多少秒
    n=`echo "86400*7"|bc`
    e_t1=$[$e_t-$n]
    e_t2=$[$e_t+$n]
	#域名到期前一周发送邮件
    if [ $t1 -ge $e_t1 ] && [ $t1 -lt $e_t ]
    then
        python mail.py  $mail_u "Domain $1 will  to be expired." "Domain $1 expire date is $e_d."
    fi
	#域名到期后一周发送邮件
    if [ $t1 -ge $e_t ] && [ $t1 -lt $e_t2 ]
    then
        python mail.py $mail_u "Domain $1 has been expired" "Domain $1 expire date is $e_d." 
    fi
}

#检测上次运行的whois查询进程是否存在
#若存在，需要杀死进程，以免影响本次脚本执行
if pgrep whois &>/dev/null
then
    killall -9 whois
fi

is_install_whois

for d in aaa.com bbb.com  aaa.cn
do
    notify $d &
done
