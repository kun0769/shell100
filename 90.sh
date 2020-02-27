#!/bin/bash
#
#program:
#    提示要输入对方的ip和root密码，然后可以自动把本机的公钥增加到对方机器上，从而实现密钥认证。
#
#history:
#2020/02/27    kun    V1.0

read -p "请输入目标机器IP地址: " ip
read -p "请输入此机器root密码: " passwd

is_install()
{
    if ! rpm -q $1 &>/dev/null
    then
        yum install -y $1
    fi
}

#ssh-copy-id命令通过openssh-cliens包安装
is_install openssh-cliens
is_install expect

if [ ! -f ./ssh/id_ras.pub ]
then
    #没有公钥自动添加
    echo -e "\n" |ssh-keygen -P ''
fi

cat > key.exp <<"EOF"
#!/usr/bin/expect
set host [lindex $argv 0]
set passwd [lindex $argv 1]

spawn ssh-copy-id root@$host
expect {
    "yes/no" {send "yes\r"}
    "password:" {send "$passwd\r"}
}
expect eof
EOF

chmod a+x key.exp
./key.exp $ip $passwd
