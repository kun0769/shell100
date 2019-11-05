#!/bin/bash
#
#program:
#    对比文件差异 把对比文件和脚本scp到B机器上来比较
#
#history:
#2019/09/20   kun    V1.0

targetdir=/data/web
file=/tmp/file.list
file_diff_a=/tmp/file_a.list
b_ip=1.1.1.1


find $targetdir/ -type f > $file
[ -f $file_diff_a ] && rm -rf $file_diff_a

while read line
do
    md5sum $line >> $file_diff_a
done < $file

cat > diff.sh <<"EOF"
#!/bin/bash

targetdir=/data/web

while read line
do
    md5=$(echo $line |awk '{print $1}')
    file_name=$(echo $line |awk '{print $2}')
    if [ -f $file_name ];then
        md5_b=$(md5sum $file_name)
        [ $md5 == $md5_b ] && echo "$file_name is changed..."
    else
        echo "$file_name is not exist..."
    fi
done < $file_diff_a

EOF

scp $file_diff_a diff.sh $b_ip:/tmp
ssh $b_ip "bin/bash /tmp/diff.sh"
