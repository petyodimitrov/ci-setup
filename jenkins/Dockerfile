FROM jenkins:1.625.1
MAINTAINER Petyo Dimitrov
ENV REFRESHED_AT 2015-10-24

# Do not drop root to allow jenkins to start containers on the host (dind)
USER root

# Add docker compose
ENV DOCKER_COMPOSE_VERSION="1.5.0rc1"
RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
  chmod +x /usr/local/bin/docker-compose

# Prep Jenkins Directories
RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins

# Set Defaults
ENV JAVA_OPTS="-Xmx6144m"
ENV JENKINS_OPTS="--handlerCountStartup=100 --handlerCountMax=300 --webroot=/var/cache/jenkins/war"
# for now removed option "--logfile=/var/log/jenkins/jenkins.log"

COPY plugins.txt /plugins.txt
RUN /usr/local/bin/plugins.sh /plugins.txt