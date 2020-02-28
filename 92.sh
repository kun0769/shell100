#!/bin/bash
#
#program:
#    脚本支持启动全部容器、关闭全部容器、删除全部容器
#
#history:
#2020/02/28    kun    V1.0

while :
do
    read -p "请输入你要执行的操作：(stop/start/rm) " opt
    if [ -z "$opt" ]
    then
        echo "请输入要执行的操作。"
        continue
    else
        break
    fi
done

#-q 只输入容器id
docker ps -a -q > 92_id.txt

case $opt in
    stop)
        for i in `cat 92_id.txt`
        do
            docker stop $i
        done
        ;;
    start)
        for i in `cat 92_id.txt`
        do
            docker start $i
        done
        ;;
    rm)
        for i in `cat 92_id.txt`
        do
            read -p "将要删除容器$id，是否继续？(y|n) " c
            case $c in
                Y|y)
                    docker rm -rf $i
                    ;;
                N|n)
                    echo "容器$i不会被删除。"
                    ;;
                *)
                    echo "你只能输入'y'或者'n'。"
                    ;;
            esac
        done
    *)
        echo "你只能输入start/stop/rm。"
        ;;
esac
