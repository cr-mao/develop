#!/bin/bash 


# 普通数组和关联数组

array_name=(linux shell awk openstack docker)
echo ${array_name[3]}




#下标定义数组
#array_name1=([1]=value1 [2]=value2 [3]=value3...)

# 普通数组
#declare -a array
# 关联数组
#declare -A array




declare -A info1
info1=([name]=tianyun [sex]=male [age]=36)
echo ${info1[age]}




#　间接定义数组 
array3[0]=pear
array3[1]=apple
array3[2]=orange
array3[3]=peach



# 从文本中读入定义数组

array=(`cat /etc/passwd`) # 文件中每一行作为与元素赋值给数组
echo ${array[*]} # 引用变量




echo ${!array[*]} 访问数组所有索引
echo ${!array[@]} 访问数组所有索引
echo ${array[*]} 访问数组所有值
echo ${array[@]} 访问数组所有值
echo ${#array[@]} 访问数组元素个数
echo ${array[@]:1}  从下标1开始
echo ${array[@]:1:2}  从数组下标1开始，访问2个元素
echo ${#array[#]}  # 第#个元素的字符个数， 第二个# 要替换为数字
echo ${#array} 第0个元素的字符个数
echo ${array} 显示第0个元素
echo ${array[#]}  显示第# 个元素


# 赋值
array_name[index1]=value1
unset array[1] # 删除
unset array # 删除整个数组



# 数组截取和替换
array=(1,2,3,4,5,6,7,8)
echo ${array[@]:0:3} # 1,2,3
echo ${array[@]:1:4} # 2,3,4,5

c=(${array[@]:1:4})  # c就是一个新数组


${数组名[@或者*]/查找字符/替换字符}
