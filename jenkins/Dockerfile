FROM jenkins:1.625.1
MAINTAINER Petyo Dimitrov

# Prep Jenkins Directories
# Do not drop root to allow jenkins to start containers on the host (dind)
USER root
RUN mkdir /var/log/jenkins
RUN mkdir /var/cache/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
RUN chown -R jenkins:jenkins /var/cache/jenkins

# Set Defaults
ENV JAVA_OPTS="-Xmx8192m"
ENV JENKINS_OPTS="--handlerCountStartup=100 --handlerCountMax=300 --webroot=/var/cache/jenkins/war"
# for now removed option "--logfile=/var/log/jenkins/jenkins.log"

COPY plugins.txt /plugins.txt
RUN /usr/local/bin/plugins.sh /plugins.txt