#!/bin/bash
#
#program:
#    重启Tomcat进程
#
#history:
#2020/02/27    kun    V1.0

dir=/usr/local/tomcat/bin

stop()
{
    cd $dir && ./shutdown.sh
    sleep 10
    
    count=0
    while [ $count lt 5 ]
    do
        if pgrep java &>/dev/null
        then
            killall java
            sleep 10
            count=$[$count+1]
        else
            break
        fi
    done

    if pgrep java &>/dev/null
    then
        killall -9 java
        sleep 10
    fi

    if pgrep java &>/dev/null
    then
        echo "Tomcat进程无法杀死."
    fi
}

start()
{
    cd $dir && ./startup.sh
}

stop
start
