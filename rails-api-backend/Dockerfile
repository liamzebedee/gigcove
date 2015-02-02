FROM ruby:2.2-wheezy

ENV DEBIAN_FRONTEND noninteractive
RUN mkdir /app
WORKDIR /app

# Rails app
ADD ./Gemfile /app/Gemfile
ADD ./Gemfile.lock /app/Gemfile.lock
RUN bundle package --all --no-prune
RUN bundle install

# General
WORKDIR /app
ADD . /app