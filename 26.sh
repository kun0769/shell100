#!/bin/bash
#
#program:
#    监控MySQL服务
#
#history:
#2019/09/22    kun    V1.0

mysql="/usr/local/mysql/bin/mysql -uroot -p12345"
if ! $mysql -e "show process" >/dev/null 2>&1
then
    echo "没有MySQL服务启动..." 
    exit
else
    $mysql -e "show slave status\G" >/tmp/slave.status 2>/dev/null
    n=$(wc -l /tmp/slave.status |awk '{print $1}')
    if [ $n -eq 0 ];then
        echo "这是主机."
    else
        echo "这是从机."
        egrep "(Slave_IO_Running:|Slave_SQL_Running:)" /tmp/slave.status |awk -F': ' '{print $2}' >/tmp/sql.tmp
        if grep -qw "NO" /tmp/sql.tmp
        then
            echo "从机没有起来."
        fi
    fi
fi


