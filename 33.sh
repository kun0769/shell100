#!/bin/bash
#
#program:
#    脚本第一个参数是url 第二个参数是目录 把文件下载到目录下
#
#history:
#2019/11/10    kun    V1.0

download(){
    if [ $# -ne 2 ];then
        echo "请输入两个参数,第一个为url,第二个为目录."
        exit 1
    
    else
        if [ ! -d $2 ];then
            while :
            do
                read -p "$2不是目录,是否要创建改目录(Y/N):" c
                case $c in
                    Y|y)
                    mkdir -p $2
                    break
                    ;;
                    N|n)
                    exit 51
                    ;;
                    *)
                    continue
                    ;;
                esac
            done
        fi
        cd $2
        wget $1
        if [ $? -ne 0 ];then
            exit 52
        fi
    fi
}

download $@
