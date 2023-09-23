#!/bin/bash

# 变量的删除，替换，代替


# 代替
port=${port-3306}
echo $port # 3306

port=${port-3307}
echo $port #3006

# 替换
var=www.baidu.com
# / 只替换第一个
echo ${var/baidu/crmao}


var=www.sina.com.cn
# // 替换所有
echo ${var//n/N}





# ${变量名#关键字}    从头开始符合删除，最短删除
# ${变量名##关键字}   从头开始符合删除，最长删除


# ${变量名%关键字}   从尾部符合删除，最短删除 
# ${变量名#%关键字}   从尾部符合删除，最长删除 






