FROM golang

RUN groupadd wwwg \
    && useradd -g wwwg www

#不要分散开来传递，否则会把文件层级搞乱
COPY . /usr/local/spider

RUN chown -R www:wwwg *

WORKDIR /usr/local/spider/bin

RUN go env -w GOPROXY=https://mirrors.aliyun.com/goproxy/,direct \
    && go mod vendor \
    && go build main.go

EXPOSE 8000

ENTRYPOINT  ./main
