FROM nodesource/node:trusty

ENV DEBIAN_FRONTEND noninteractive

# SASS
RUN apt-get install -y software-properties-common
RUN apt-add-repository -y ppa:brightbox/ruby-ng
RUN apt-get update
RUN apt-get install -y ruby2.2 ruby-dev

RUN gem install bundler \
	&& bundle config --global path "$GEM_HOME" \
	&& bundle config --global bin "$GEM_HOME/bin"

RUN gem install compass

VOLUME ["/app", "/app/node_modules"]
WORKDIR /app

RUN npm install -g grunt-cli