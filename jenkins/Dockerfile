FROM jenkins:1.651.2
MAINTAINER Petyo Dimitrov
ENV REFRESHED_AT 2016-05-24

USER root

# add docker compose
ENV DOCKER_COMPOSE_VERSION="1.7.1"
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

# prepare Jenkins directories
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins

# set defaults
ENV JAVA_OPTS="-Xmx6144m"
ENV JENKINS_OPTS="--handlerCountStartup=100 --handlerCountMax=300 --webroot=/var/cache/jenkins/war"

COPY plugins.txt /plugins.txt
RUN /usr/local/bin/plugins.sh /plugins.txt