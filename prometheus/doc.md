## prometheus+alertmanager+飞书告警

1. 执行 node_exporter_install.sh

2. 执行 prometheus_install.sh

3. 替换prometheus.yml配置文件，复制node_exporter_rule.yml(报警规则) 到prometheus 目录 然后重启

- 已对磁盘使用率，内存使用率，cpu使用率，磁盘读、写速度>100mb/s, 网络接口发送、接受， oom事件 做了监控

4. 安装alertmanager,执行alertmanager_install.sh

5. 安装prometheusAlert ，执行 prometheusAlert.sh

alertmanager 的配置文件修改webhook，

url: "http://192.168.56.10:8088/prometheusalert?type=fs&tpl=prometheus-fs&fsurl=https://open.feishu.cn/open-apis/bot/v2/hook/xxxx"

修改配置文件conf/app.conf, open-feishu=1 开启飞书

6. 安装grafana

granfana_install.sh

http://192.168.56.10:3000/ 默认admin,admin

添加数据源 prometheus ,改下url
然后倒入node-exporter-fuu_rev.31.json即可 ，可以做适当的删除。




## web 页面

http://192.168.56.10:9092/ prometheus 页面

http://192.168.56.10:9093/ alertmanager 页面

http://192.168.56.10:8088/ prometheusAlert页面

http://192.168.56.10:3000  grafana页面


NOTICE:
各个组件所在机器的时区要相同。 不然展示就有问题。



## 参看文档
- https://www.cnblogs.com/fwynb/p/17044216.html
