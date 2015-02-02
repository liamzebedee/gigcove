FROM nodesource/node:trusty

ENV DEBIAN_FRONTEND noninteractive
RUN mkdir /app
WORKDIR /app

ADD ./package.json /app/package.json
RUN npm update npm -g
RUN npm install

WORKDIR /app
ADD . /app