FROM ruby
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN mkdir /railsapp
WORKDIR /railsapp
ADD Gemfile /railsapp/Gemfile
ADD Gemfile.lock /railsapp/Gemfile.lock
RUN bundle package --all
RUN bundle install
ADD . /railsapp