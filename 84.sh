#!/bin/bash
#
#program:
#    把A服务器上的变更代码同步到B和C上。 其中，你需要考虑到不需要同步的目录（假如有tmp、upload、logs、caches）
#
#history:
#2020/02/26    kun    V1.0

#更新ABC代码的路径一致
dir=/data/www/www.a.com
b_ip=1.1.1.1
c_ip=2.2.2.2

rs()
{
    rsync -azP --exclude="tmp" --exclude="upload" --exclude="logs" --exclude="caches" $dir/ $1:$dir/
}

read -p "本脚本会把A中$dir代码同步到$b_ip和$c_ip中,是否继续(y/n): " c

case $c in
    Y|y)
        rs $b_ip
        rs $c_ip
        ;;
    N|n)
        exit
        ;;
    *)
        echo "请输入y或n." && exit
        ;;
esac
