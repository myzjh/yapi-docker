FROM node:12-alpine as builder

COPY yapi-1.9.2.tar.gz /home

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
  apk update && apk add --no-cache git python make openssl tar gcc && \
  cd /home && tar zxvf yapi-1.9.2.tar.gz && mv /home/yapi-1.9.2 /api/192

FROM node:12-alpine
WORKDIR "/api/192"
COPY --from=builder /api/192 /api/192
COPY config.json /api

RUN cd /api/192 && npm install -g yapi-cli --registry https://registry.npm.taobao.org 

EXPOSE 3000 9090
