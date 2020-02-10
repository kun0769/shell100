#!/bin/bash 
#
#program:
#    自动增加标题
#
#history:
#2020/02/10    kun    V1.0

date=`date +%Y/%m/%d`

cat > $1 <<EOF
#!/bin/bash
#
#program:
#    
#
#history:
#$date    kun    V1.0
EOF
