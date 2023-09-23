#!/bin/bash

os_check(){
    if [ -e /etc/redhat-release ];then
        REDHAT=`cat /etc/redhat-release |cut -d ' ' -f1`
    else
        DEBIAN=`cat /etc/issue | cut -d' ' -f1`
    fi
    if [ "$REDHAT" == "CentOS" -o "$REDHAT" == "Red" ];then
	P_M=yum
    elif [ "$DEBIAN" == "Ubuntu" -o "$DEBIAN" == "ubuntu" ];then
	P_M=apt-get
    else
	 echo "operating system does not support"
	 exit 1
    fi
}

# 查看登陆的用户是否是root
if [ $LOGNAME != root ]; then
	echo "please use the root account operation."
	exit 1
fi


if  ! which vmstat &>/dev/null;then
    echo "vmstat command not found,now install."
    sleep 1
    os_check
    $P_M install procps -y
    echo "--------------------------------------"
fi



if ! which iostat &>/dev/null;then
    echo "iostat command not found ,not install ."
    sleep 1
    os_check
    $P_M install sysstat -y
    echo "------------------------"
fi


while true;do
    select input in cpu_load disk_load mem_use tcp_status cpu_top10 mem_top10 traffic quit;do
        case $input in
            cpu_load)
		echo "---------------------------"
		i=1
                while [[ $i -le 3 ]];do
			echo -e "\033[32m 参考值${i} \033[0m"
                        UTIL=`vmstat | awk '{if(NR==3) print 100-$15"%"}'`
                        USER=`vmstat | awk '{if(NR==3) print $13"%"}'`
                        SYS=`vmstat | awk '{if(NR==3) print $14"%"}'`
                        IOWAIT=`vmstat | awk '{if(NR==3) print $16"%"}'`
			echo "Util: $UTIL"
			echo "User use: $USER"
			echo "Sytem use: $SYS"
			echo "I/O wait: $IOWAIT"
			i=$(($i+1))
			sleep 1
		done
		echo "---------------------------"
		break
		;;
	    disk_load)
		# 硬盘i/0负载
		i=1
		while [[ $i -le 3 ]];do
		    echo -e "\033[32m 参考值${i} \033[0m"
		    UTIL=`iostat -x -k | awk '/^v|s/{OFS=": ";print $1,$NF"%"}'`
		    READ=`iostat -x -k | awk '/^v|s/{OFS=": ";print $1,$4"KB"}'`
		    WRITE=`iostat -x -k | awk '/^v|s/{OFS=": ";print $1,$5"KB"}'`
		    IOWAIT=`vmstat | awk '{if(NR==3) print $16"%"}'`
                    echo -e "Util:"
		    echo -e "${UTIL}"
		    echo -e "I/O wait: $IOWAIT"
                    echo -e "READ/s:\n$READ"
		    echo -e "Write/s:\n$WRITE"
		    i=$(( $i+1 ))
		    sleep 1
		done
		echo "-----------------------------"
		break
		;;
	     tcp_status)
		echo "-----------------------------";
		COUNT=`netstat -antp | awk '{status[$6]++}END{ for ( i in status) print i,status[i]}'`
		echo -e "TCP connection status :\n $COUNT"
		echo "-----------------------------------"
		break
		;;
             mem_use)
		# 内存使用率
		echo "-------------------------------------"
		MEM_TOTAL=`free -m | awk '{if(NR==2) printf "%.1f",$2/1024}END{print"G"}'`

		USE=`free -m | awk '{if(NR==3) printf "%.1f",$3/1024}END{print"G"}'`
		FREE=`free -m | awk '{if(NR==3) printf "%.1f",$4/1024}END{print"G"}'`
		CACHE=`free -m | awk '{if(NR==2) printf "%.1f",$5/1024}END{print"G"}'`
		echo -e "TOTAL: $MEM_TOTAL"
		echo -e "Use: $USE"
		echo -e "Free: $FREE"
		echo -e "Cache: $CACHE"
		echo "------------------------"
		break
		;;
	     cpu_top10)
		# 占用cpu 高的前10个进程
		echo "----------------------"
		CPU_LOG=/tmp/cpu_top.tmp
		i=1
		while [[ $i -le 3 ]];do
		    ps aux | awk '{if($3>0.1){{printf "pid: "$2" CPU: "$3"%--->"}for(i=11;i<=NF;i++) if (i==NF)printf $i"\n";else printf $i}}' | sort -k4 -nr | head -n 10 > $CPU_LOG
		    if [[ -n `cat $CPU_LOG` ]]; then
			echo -e "\033[32m 参考值 ${i} \033[0m"
			cat $CPU_LOG
			> $CPU_LOG
		    else
			echo "no process using in cpu."
			break
		    fi
		    i=$(($i+1))
		    sleep 1
		done
		break
		;;
	     mem_top10)
		# 占用内存 高的前10个进程
		echo "----------------------"
		MEM_LOG=/tmp/mem_top.tmp
		i=1
		while [[ $i -le 3 ]];do
		    ps aux | awk '{if($4>0.1){{printf "pid: "$2" Memory: "$4"%--->"}for(i=11;i<=NF;i++) if (i==NF)printf $i"\n";else printf $i}}' | sort -k4 -nr | head -n 10 > $MEM_LOG
		    if [[ -n `cat $MEM_LOG` ]]; then
			echo -e "\033[32m 参考值 ${i} \033[0m"
			cat $MEM_LOG
			> $MEM_LOG
		    else
			echo "no process using in Memory."
			break
		    fi
		    i=$(($i+1))
		    sleep 1
		done
		break
		;;
	     quit)
		exit 0
		;;

	    *)
		echo "--------------------------"
		echo "Please enter the number."
		echo "--------------------------"
		break
		;;
	esac
     done
done


