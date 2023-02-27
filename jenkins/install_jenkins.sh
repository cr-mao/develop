#!/bin/bash
#
#********************************************************************
#Author:            cr-mao
#Date:              2020-02-15
#FileName:          install_jenkins.sh
#URL:               https://www.crblog.cc
#Description:       本脚本只支持Jenkins-2.319.3前版本
#Copyright (C):     2020 All rights reserved
#********************************************************************

#JENKINS_VERSION=2.319.3
JENKINS_VERSION=2.346.2
URL="https://mirrors.tuna.tsinghua.edu.cn/jenkins/debian-stable/jenkins_${JENKINS_VERSION}_all.deb"
#URL="https://mirrors.aliyun.com/jenkins/debian-stable/jenkins_${JENKINS_VERSION}_all.deb"
#URL="https://mirrors.aliyun.com/jenkins/debian-stable/jenkins_2.303.2_all.deb"
#URL="https://mirrors.tuna.tsinghua.edu.cn/jenkins/debian-stable/jenkins_2.289.3_all.deb"
#URL="https://mirrors.aliyun.com/jenkins/debian-stable/jenkins_2.289.3_all.deb"
#URL="https://mirrors.tuna.tsinghua.edu.cn/jenkins/redhat-stable/jenkins-2.289.3-1.1.noarch.rpm"

GREEN="echo -e \E[32;1m"
END="\E[0m"

HOST=`hostname -I|awk '{print $1}'`
. /etc/os-release


color () {
    RES_COL=60
    MOVE_TO_COL="echo -en \\033[${RES_COL}G"
    SETCOLOR_SUCCESS="echo -en \\033[1;32m"
    SETCOLOR_FAILURE="echo -en \\033[1;31m"
    SETCOLOR_WARNING="echo -en \\033[1;33m"
    SETCOLOR_NORMAL="echo -en \E[0m"
    echo -n "$1" && $MOVE_TO_COL
    echo -n "["
    if [ $2 = "success" -o $2 = "0" ] ;then
        ${SETCOLOR_SUCCESS}
        echo -n $"  OK  "
    elif [ $2 = "failure" -o $2 = "1"  ] ;then
        ${SETCOLOR_FAILURE}
        echo -n $"FAILED"
    else
        ${SETCOLOR_WARNING}
        echo -n $"WARNING"
    fi
    ${SETCOLOR_NORMAL}
    echo -n "]"
    echo
}


install_java(){
    if [ $ID = "centos" -o $ID = "rocky" ];then
        #yum -y install java-1.8.0-openjdk
        yum -y install java-11-openjdk
    else
        apt update
        #apt -y install openjdk-8-jdk
       apt -y install openjdk-11-jdk
    fi

    if [ $? -eq 0 ];then
       color "安装java完成!" 0
    else
       color "安装java失败!" 1
       exit
    fi
}


install_jenkins() {
    wget -P /usr/local/src/ $URL || { color  "下载失败!" 1 ;exit ; }
    if [ $ID = "centos" -o $ID = "rocky" ];then
        yum -y install /usr/local/src/${URL##*/}
        ystemctl enable  jenkins
        systemctl start jenkins
    else
        apt -y install daemon net-tools || { color  "安装依赖包失败!" 1 ;exit ; }
        # 取url 最后斜杠 后面的部分。
        dpkg -i  /usr/local/src/${URL##*/}
    fi

    if [ $? -eq 0 ];then
       color "安装Jenkins完成!" 0
    else
       color "安装Jenkins失败!" 1
       exit
    fi
}


start_jenkins() {
    systemctl is-active jenkins
    if [ $?  -eq 0 ];then
        echo
        color "Jenkins安装完成!" 0
        echo "-------------------------------------------------------------------"
        echo -e "访问链接: \c"
        ${GREEN}"http://$HOST:8080/"${END}
    else
        color "Jenkins安装失败!" 1
        exit
    fi
     while :;do
        [ -f /var/lib/jenkins/secrets/initialAdminPassword ] && \
        { key=`cat /var/lib/jenkins/secrets/initialAdminPassword` ; break; }
        sleep 1
     done
     echo -e "登录秘钥: \c"
     ${GREEN}$key${END}
}


install_java
install_jenkins
start_jenkins
