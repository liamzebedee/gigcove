FROM ruby
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN mkdir /railsapp
WORKDIR /railsapp
ADD Gemfile /railsapp/Gemfile
ADD Gemfile.lock /railsapp/Gemfile.lock
RUN bundle package --all --no-prune
RUN bundle install
ADD . /railsapp