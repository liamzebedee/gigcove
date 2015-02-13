FROM nodesource/node:trusty

ENV DEBIAN_FRONTEND noninteractive
RUN mkdir /app
WORKDIR /app

# SASS
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get install -y ruby2.2 ruby-dev

RUN gem install bundler \
	&& bundle config --global path "$GEM_HOME" \
	&& bundle config --global bin "$GEM_HOME/bin"

RUN gem install compass

COPY ./package.json /app/package.json
COPY ./node_modules /app/node_modules
RUN npm install -g grunt-cli
RUN npm install

# General
#WORKDIR /app
ADD . /app