FROM node:6.9.1-alpine
MAINTAINER mist.io <support@mist.io>

RUN apk add --update --no-cache git nginx

RUN npm install -g -U polymer-cli@1.6.0 bower

ENV bower_allow_root=true \
    bower_interactive= \
    GIT_DIR=

COPY bower.json /elements/bower.json

WORKDIR /elements

RUN bower install

COPY . /elements

RUN /usr/local/bin/polymer build && cp bower_components/echarts/dist/echarts.common.min.js build/bundled/bower_components/echarts/dist/echarts.common.min.js

COPY ./container/nginx.conf /etc/nginx/nginx.conf

COPY ./container/entry.sh /entry.sh

EXPOSE 80
