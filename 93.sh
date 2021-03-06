#!/bin/bash    
#    
#program:    
#    一键安装并配置samba服务
#    
#history:    
#2020/02/28    kun    V1.0  

if [ "$#" -ne 1 ]
then
    echo "运行脚本的格式为：$0 /dir/"
    exit 1
else
    if ! echo $1 |grep -q '^/.*'
    then
        echo "请提供一个绝对路径。"
        exit 1
    fi
fi

if ! rpm -q samba &>/dev/null
then
    echo "将要安装samba"
    sleep 1
    yum install -y samba
    if [ $? -ne 0 ]
    then
        echo "samba安装失败"
        exit 1
    fi
fi

cnfdir="/etc/samba/smb.conf"
cat >> $cnfdir <<EOF
[share]
        comment = share all
        path = $1
        browseable = yes
        public = yes
        writable = no
EOF

if [ ! -d $1 ]
then
    mkdir -p $1
fi

chmod 777 $1
echo "test" > $1/test.txt

#假设系统为CentOS7
systemctl start smb
if [ $? -ne 0 ]
then
    echo "samba服务启动失败，请检查配置文件是否正确。"
else
    echo "samba配置完毕，请验证。"
fi