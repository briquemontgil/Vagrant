#
#Install apache2
#Pour Ubuntu server
#

#Based on ubuntu 14.04
FROM ubuntu:14.04
MAINTAINER Lucas Laurent "lucas.laurent04@gmail.com"

#************ Add depots in apt sources.list *****************************
RUN echo "deb http://gb.archive.ubuntu.com/ubuntu/ trusty universe" > /etc/apt/source.list
RUN echo "deb-src http://gb.archive.ubuntu.com/ubuntu/ trusty universe" >> /etc/apt/source.list

#************ Handle dependencies and packets **************************
#Update and upgrade packets
RUN apt-get update -y -q
RUN apt-get upgrade -y -q
RUN apt-get dist-upgrade -y -q
#Delete out-of-date packets
RUN apt-get -y -q autoclean
#Delete packets with useless dependencies
RUN apt-get -y -q autoremove

#************ Install Packets ******************************************

RUN apt-get install -y -q ssh
RUN apt-get install -y -q supervisor
RUN apt-get install -y -q apache2

#************ Configure Packets ****************************************
#Apache2
ADD foreground.sh /etc/apache2/foreground.sh
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

#************ Import files *********************************************
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD start.sh /start.sh

#************ Expose ports *********************************************
EXPOSE 22 80

#************ Start services *******************************************
#launch start.sh
#if any pipeline ever ends with a non-zero ('error') exit status, 
#terminate the script immediately
CMD ["/bin/bash", "-e", "/start.sh"]
