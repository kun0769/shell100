#!/bin/bash    
#    
#program:    
#    自定义rm    
#    
#history:    
#2020/03/18    kun    V1.0

filename=$1

if [ ! -e $1 ]
then
    echo "$1 不存在，请使用绝对路径"
    exit
fi
d=`date +%Y%m%d%H%M`
f_size=`du -sk $1|awk '{print $1}'`
# 最大容量的磁盘空间大小
disk_size=`LANG=en; df -k |grep -vi filesystem|awk '{print $4}' |sort -n |tail -n1`
# 最大容量的分区
big_filesystem=`LANG=en; df -k |grep -vi filesystem |sort -n -k4 |tail -n1 |awk '{print $NF}'`

if [ $f_size -lt $disk_size ]
then
    read -p "Are U sure delete the file or directory: $1? y|n: " c
    case $c in 
      y|Y)
          mkdir -p $big_filesystem/.$d && rsync -aR $1 $big_filesystem/.$d/$1 && /bin/rm -rf $1
          ;;
      n|N)
          exit 0
          ;;
      *)
          echo "Please input 'y' or 'n'."
          ;;
     esac
else
    echo "The disk size is not enough to backup the files $1."
    read -p "Do you want to delete $1? y|n: " c
    case $c in
      y|Y)
        echo "It will delete $1 after 5 seconds whitout backup."
        # 慢慢打出5个点等待时间
        for i in `seq 1 5`; do echo -ne ". "; sleep 1;done
        echo
        /bin/rm -rf $1
        ;;
     n|N)
        echo "It will not delete $1."
        exit 0
        ;;
      *)
        echo "Please input 'y' or 'n'."
        ;;
    esac
fi
