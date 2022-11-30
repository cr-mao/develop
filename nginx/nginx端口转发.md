## nginx 端口转发

gitlab服务器和nginx服务器不是在同一台。
原本同事gitlab的代码拉取按理是基于域名+port的，
然后他们配置的是nginx配置的是http端口转发，如8022端口，但是ssh是基于tcp协议的，所以他们
一直用的是ip加端口的方式拉代码,作为临时解决方案



#### nginx.conf 修改

```text
load_module /usr/lib/nginx/modules/ngx_stream_module.so; # 增加开启流模式so
error_log /var/log/nginx/error.log warn;
include /etc/nginx/sites-enabled/*.tcp;      # 加载tcp stream 段的配置
```


gitlab.xxx.com.tcp 配置文件

```text
stream{
    tcp_nodelay on;
    log_format proxy '$remote_addr:$remote_port [$time_local] '
                 '$protocol $status $bytes_sent $bytes_received '
                 '$session_time "$upstream_addr" '
                 '"$upstream_bytes_sent" "$upstream_bytes_received" "$upstream_connect_time"';
    upstream sshgitlab {
                server xxx:8022;   #主机host(or 主机ip)+Port
     }
    server {
                listen 8022 so_keepalive=on;
                proxy_connect_timeout 1h;
                proxy_timeout 1h;
                proxy_pass sshgitlab;
                access_log /var/log/nginx/gitlab.log proxy;
   }
}
```



