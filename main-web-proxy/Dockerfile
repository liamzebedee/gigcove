FROM nodesource/node:trusty

ENV DEBIAN_FRONTEND noninteractive

VOLUME ["/app"]
WORKDIR /app
ADD ./package.json /app/package.json

RUN npm update npm -g
RUN echo boom
RUN npm install
RUN npm install -g grunt-cli