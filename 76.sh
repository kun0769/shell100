#!/bin/bash
#
#program:
#    根据文件中ip，用户名和密码批量登录远程机器并杀掉tomcat进程
#
#history:
#2020/02/24    kun    V1.0

cmd="ps aux |grep tomcat |grep -v grep |awk '{print $2}' |xargs kill"

cat > kill_tomcat.exp <<"EOF"
#!/usr/bin/expect
set host [lindex $argv 0]
set passwd [lindex $argv 1]
set cmd [lindex $argv 2]

spawn ssh root@$host

expect {
    "yes/no" {send "yes\r"}
    "password:" {send "$passwd\r"}
}

expect "]*"
send "$cmd\r"
expect "]*"
send "exit\r"
EOF

chmod a+x kill_tomcat.exp

cat ip-pwd.ini |while read line
do
    host=`echo $line |awk -F ',' '{print $1}'`
    pw=`echo $line |awk -F ',' '{print $3}'`
    ./kill_tomcat.exp $host $pw $cmd
done
