FROM binaryphile/ruby:2.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /railsapp
WORKDIR /railsapp
ADD Gemfile /railsapp/Gemfile
RUN bundle update
RUN bundle install
ADD . /railsapp
