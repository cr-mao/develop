FROM golang:1.21-alpine AS build
ENV CGO_ENABLED=0 GOOS=linux GO111MODULE=on GOPROXY=https://goproxy.cn/,direct  TZ=Asia/Shanghai
RUN set -eux && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update && apk add --no-cache tzdata git

WORKDIR /app

COPY ./go.mod ./
COPY ./go.sum ./

RUN go mod tidy

COPY . ./

RUN  go build -o godemo main.go && go clean -cache

FROM alpine:3.15.0
RUN set -eux && sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update && apk add --no-cache tzdata
ENV TZ "Asia/Shanghai"
WORKDIR /app
COPY --from=build /app/godemo /app/godemo
RUN chmod +x /app/godemo

EXPOSE 8000

CMD ["/app/godemo"]





