#!/bin/bash    
#    
#program:    
#    根据等额本基金法或者等额本息法得到还款等消息    
#    等额本息 每月还款额=[贷款本金×月利率×（1+月利率）^还款月数]÷[（1+月利率）^还款月数－1] 
#    等额本金 每月还款额=贷款本金÷贷款期数+（本金-已归还本金累计额）×月利率
#    
#history:    
#2020/02/25    kun    V1.0  

read -p "请输入贷款总额（单位：万元）：" sum_w
read -p "请输入贷款年利率（如年利率为6.5%，直接输入6.5）：" y_r
read -p "请输入贷款年限（单位：年）：" y_n
echo "贷款计算方式："
echo "1)等额本金计算法"
echo "2)等额本息计算法"
read -p "请选择贷款方式（1|2）" type
#贷款总额
sum=`echo "scale=2;$sum_w*10000 " | bc -l`
#年利率
y_r2=`echo "scale=6;$y_r/100 " | bc -l`
#月利率
m_r=`echo "scale=6;$y_r2/12 " | bc -l`
#期数
count=$[$y_n*12]
echo "期次 本月还款额 本月利息 未还款额"

jin()
{
    #月还款本金m_jin=贷款总额sum/期数count
    m_jin=`echo "scale=2;($sum/$count)/1 " | bc -l`
    #定义未还本金r_jin（第一期应该是贷款总额）
    r_jin=$sum
    for((i=1;i<=$count;i++))
    do
        #本月利息m_xi=剩余本金*月利率
        m_xi=`echo "scale=2;( $r_jin*$m_r)/1"|bc -l`
        #本月还款m_jinxi=月还本金m_jin+本月利息m_xi
        m_jinxi=`echo "scale=2;( $m_jin+$m_xi)/1"|bc -l`
        #已还款本金jin=月还本金m_jin*期数i
        jin=`echo "scale=2;( $m_jin*$i)/1"|bc -l`
        #剩余本金r_jin=贷款总额sum-已还本金jin
        r_jin=`echo "scale=2;( $sum-$jin)/1"|bc -l`
        if [ $i -eq $count ]
        then
            #最后一月的还款额应该是每月还款本金+本月利息+剩余本金
            m_jinxi=`echo "scale=2;( $m_jin+$r_jin+$m_xi)/1"|bc -l`
            #最后一月的剩余本金应该是0
            r_jin=0
        fi
        echo "$i  $m_jinxi  $m_xi  $r_jin"
     done   
}

xi()
{
    #每期还款m_jinxi=(贷款总额sum*月利率m_r*((1+月利率m_r）^期数count))/(((1+月利率m_r)^期数count)-1)
    m_jinxi=`echo "scale=2;(($sum*$m_r*((1+$m_r)^$count))/(((1+$m_r)^$count)-1))/1 " | bc -l`
    #定义未还本金r_jin（第一期应该是贷款总额）
    r_jin=$sum
    for((i=1;i<=$count;i++))
    do
        #本期利息m_xi=剩余本金r_jin*月利率m_r
        m_xi=`echo "scale=2;( $r_jin*$m_r)/1"|bc -l`
        #本期本金m_jin=本期本息m_jinxi-本期利息m_xi
        m_jin=`echo "scale=2;($m_jinxi-$m_xi)/1 " | bc -l`
        #未还本金r_jin=上期未还本金r_jin-本期应还本金m_jin
        r_jin=`echo "scale=2;($r_jin-$m_jin)/1 " | bc -l`
        if [ $i -eq $count ]
        then
            #最后一月本息m_jinxi=本期本金m_jin+未还本金r_jin
            m_jinxi=`echo "scale=2;($m_jin+$r_jin)/1 " | bc -l`
            #最后一月的剩余本金应该是0
            r_jin="0.00"
        fi
        echo "$i $m_jinxi $m_xi $r_jin"
    done
}

case $type in
    1) 
        jin
        ;;
    2) 
        xi
        ;;
    *) 
        exit 1
        ;;
esac
