#!/bin/bash

# 机器ssh 互通

if [ $# -lt 2];then
	echo "Useage sh $0 user_name user_pass"
	exit 1;
fi

# 初始化变量
ROOT_PASS="alalal123"
USER_NAME=$1
USER_PASS=$2
# 不包含本机
HOST_LIST="192.168.56.80"

useradd -m $USER_NAME
# ubuntu 没有这个
#echo  $USER_PASS | passwd --stdin $USER_NAME
echo $USER_NAME:$USER_PASS |   chpasswd

# 生成用户的
sudo su - $USER_NAME  -c "echo "" | ssh-keygen -t rsa"
PUB_KEY="`cat /home/${USER_NAME}/.ssh/id_rsa.pub`"

for  host in $HOST_LIST;do
  sshpass -p$ROOT_PASS ssh -o StrictHostKeyChecking=no root@$host "useradd -m $USER_NAME"
  sshpass -p$ROOT_PASS ssh -o StrictHostKeyChecking=no root@$host "echo $USER_NAME:$USER_PASS |   chpasswd"
  sshpass -p$ROOT_PASS ssh -o StrictHostKeyChecking=no root@$host "mkdir -p /home/$USER_NAME/.ssh"
  sshpass -p$ROOT_PASS ssh -o StrictHostKeyChecking=no root@$host "echo $PUB_KEY >> /home/$USER_NAME/.ssh/authorized_keys"
  sshpass -p$ROOT_PASS ssh -o StrictHostKeyChecking=no root@$host "chmod 600 /home/$USER_NAME/.ssh/authorized_keys"
  sshpass -p$ROOT_PASS ssh -o StrictHostKeyChecking=no root@$host "chown -R $USER_NAME:$USER_NAME /home/$USER_NAME/.ssh"
done

