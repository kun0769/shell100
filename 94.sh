#!/bin/bash
#
#program:
#    批量登录远程的机器并打印出机器负载
#
#history:
#2020/03/16    kun    V1.0

#判断是否有test密钥
if [ ! -f /tmp/test ]
then
    ssh-keygen -f /tmp/test -N 'root1234'
    #批量把公钥发送到目标机器
    for ip in `cat ip.list`
    do
        ssh-copy-id -i /tmp/test -f root@$ip
    done
fi

#当前终端运行ssh-agent并把密钥密码加载到内存中
eval `ssh-agent`
ssh-add /tmp/test

for ip in `cat ip.list`
do
    ssh -i /tmp/test root@$ip "w"
done
