FROM ruby:2.2-wheezy

ENV DEBIAN_FRONTEND noninteractive
RUN mkdir /app
WORKDIR /app

# Rails app
ADD ./Gemfile /app/Gemfile
ADD ./Gemfile.lock /app/Gemfile.lock
ADD ./vendor/cache /app/vendor/cache
RUN bundle update
RUN bundle install
RUN bundle package --all --no-prune

# General
WORKDIR /app
VOLUME ["/app"]
ADD . /app