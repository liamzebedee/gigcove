FROM ruby
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN mkdir /railsapp
WORKDIR /railsapp
ADD Gemfile /railsapp/Gemfile
ADD Gemfile.lock /railsapp/Gemfile.lock
RUN bundle install --deployment --path "/railsapp/vendor/bundle"
ADD . /railsapp