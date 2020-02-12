#!/bin/bash
#
#program:
#    判断当前主机的CPU生产商
#
#history:
#2020/02/12    kun    V1.0

cpu=`grep "vendor_id" /proc/cpuinfo |awk -F ' |:' '{print $3}'`

case $cpu in 
    AuthenticAMD)
        echo "CPU是AMD"
    ;;
    
    GenuineIntel)
        echo "CPU是Intel"
    ;;

    *)
        echo "CPU是杂牌货"
    ;;
esac
