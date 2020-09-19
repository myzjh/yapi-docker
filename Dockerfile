FROM node:12-alpine as builder

COPY yapi-1.9.2.tar.gz /home

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
  apk update && apk add --no-cache git python make openssl tar gcc && \
  cd /home && tar zxvf yapi-1.9.2.tar.gz

FROM node:12-alpine
COPY --from=builder /home/yapi-1.9.2 /yapi
COPY config.json /yapi

RUN npm install -g yapi-cli --registry https://registry.npm.taobao.org

EXPOSE 3000 9090
