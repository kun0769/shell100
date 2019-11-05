#!/bin/bash
#
#program:
#    带选项的增删用户脚本
#
#history:
#2019/09/22    kun    V1.0

if [ $# -eq 0 ] || [ $# -gt 2 ] || [ $# -eq 1 ]
then
    echo "Usage: [--add user|--add user1,user2] [--del user|--del user1,user2] [--help]"    
    exit
fi

#判断用户存在并添加用户
add_user(){
    if id $1 >/dev/null 2>&1
    then 
        echo "$1 is exist."
    else
        echo "$1 add successful."
        useradd $1
        echo "$1" |passwd --stdin $1
    fi
}

#判断用户存在并删除用户
del_user(){
        if id $1 >/dev/null 2>&1
    then
         echo "$1 delete successful."
        userdel -r $1
    else
        echo "$1 is not exist."
    fi
}

case $1 in
    --add)
        n=$(echo $2 |awk -F',' '{print NF}')
        for i in $(seq 1 $n);do
            user=$(echo $2 |awk -v j=$i -F',' '{print $j}') 
            add_user $user 
        done
    ;;
    --del)
        n=$(echo $2 |awk -F',' '{print NF}')
        for i in $(seq 1 $n);do
            user=$(echo $2 |awk -v j=$i -F',' '{print $j}')
            del_user $user
        done

    ;;
    --help)
        echo "Usage: [--add user|--add user1,user2] [--del user|--del user1,user2] [--help]"
    ;;
    *)
        echo "Usage: [--add user|--add user1,user2] [--del user|--del user1,user2] [--help]"
    ;;
esac
