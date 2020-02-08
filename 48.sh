#!/bin/bash
#
#program:
#    判断是否安装httpd和mysql，没有安装进行安装，安装了检查是否启动服务，若没有启动则需要启动服务
#
#history:
#2020/02/08    kun    V1.0

check_install(){
    if rpm -q $1 >/dev/null 2>&1;then
        echo "$1已经安装"
    else
        echo "$1没有安装,正在安装..."
	yum install -y $1
    fi
}

check_server(){
    if ! pgrep $1 >/dev/null 2>&1;then
        echo "$1服务没有启动，正在启动中..."
        systemctl start $1
    else
        echo "$1已经启动了"
    fi
}

check_install httpd
check_install mysql-server
check_server httpd
check_server mysqld
