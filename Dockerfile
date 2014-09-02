FROM ruby
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update #&& apt-get install -y build-essential libpq-dev
RUN mkdir /railsapp
WORKDIR /railsapp
ADD Gemfile /railsapp/Gemfile
RUN bundle update
RUN bundle install
ADD . /railsapp