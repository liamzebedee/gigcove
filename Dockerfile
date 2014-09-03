FROM ruby
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN mkdir /railsapp
WORKDIR /railsapp
ADD Gemfile /railsapp/Gemfile
RUN bundle install
ADD . /railsapp