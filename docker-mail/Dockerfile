FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive
RUN debconf-set-selections << "postfix postfix/mailname string gigcove.com"
RUN debconf-set-selections << "postfix postfix/main_mailer_type string 'Internet Site'"
RUN apt-get update -qq && apt-get install -y postfix mailutils nano telnet	
ADD main.cf /etc/postfix/main.cf
ADD mailname /etc/mailname
ENV DEBIAN_FRONTEND interactive
ADD fig-service.sh /root/fig-service.sh