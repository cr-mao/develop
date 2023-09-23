```shell

# nginx
docker run --name nginx-app \
-v /app/nginx/html:/usr/share/nginx/html:ro \
-v /app/nginx/conf:/etc/nginx
-d nginx


#mysql
docker run -p 3306:3306 --name mysql57-app \
-v /app/mysql/log:/var/log/mysql \
-v /app/mysql/data:/var/lib/mysql \
-v /app/mysql/conf:/etc/mysql/conf.d \
-e MYSQL_ROOT_PASSWORD=123456 \
-d mysql:5.7


# mongo
docker run -d --name mymongo -v /Users/maozhongyu/docker_data/mongo_data:/data/db mongo:4

 # mongo client
docker run --link mymongo:mongo -p 8081:8081 mongo-express


# 提前准备好redis.conf文件，创建好相应的文件夹。如： port 6379 appendonly yes
# 更多配置参照 https://raw.githubusercontent.com/redis/redis/6.0/redis.conf

docker run -p 6379:6379 --name redis \
-v /app/redis/redis.conf:/etc/redis/redis.conf \
-v /app/redis/data:/data \
-d redis:6.2.1-alpine3.13 \ redis-server /etc/redis/redis.conf --appendonly yes





#准备文件和文件夹，并chmod -R 777 xxx #配置文件内容，参照 https://www.elastic.co/guide/en/elasticsearch/reference/7.5/node.name.html 搜索相 关配置
#
# 考虑为什么挂载使用esconfig ...
#
#
docker run --name=elasticsearch -p 9200:9200 -p 9300:9300 \
-e "discovery.type=single-node" \
-e ES_JAVA_OPTS="-Xms300m -Xmx300m" \
-v /app/es/data:/usr/share/elasticsearch/data \
-v /app/es/plugins:/usr/shrae/elasticsearch/plugins \
-v esconfig:/usr/share/elasticsearch/config \
-d elasticsearch:7.12.0




# 考虑，如果我们每次 -v 都是指定磁盘路径，是不是很麻烦？
#
docker run --name tomcat-app -p 8080:8080 \
-v tomcatconf:/usr/local/tomcat/conf \
-v tomcatwebapp:/usr/local/tomcat/webapps \
-d tomcat:jdk8-openjdk-slim-buster
```



