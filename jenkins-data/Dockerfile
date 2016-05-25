FROM debian:jessie
MAINTAINER Petyo Dimitrov
ENV REFRESHED_AT 2016-05-24

# create the jenkins user
RUN useradd -d "/var/jenkins_home" -u 1000 -m -s /bin/bash jenkins

# create the folders and volume mount points
VOLUME ["/var/jenkins_home"]

USER jenkins

COPY jobs/ /var/jenkins_home/jobs/
RUN echo "listing preconfigured jobs: " && ls /var/jenkins_home/jobs/

CMD ["echo", "data-only container for Jenkins"]