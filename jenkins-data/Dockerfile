FROM debian:jessie
MAINTAINER Petyo Dimitrov
ENV REFRESHED_AT 2015-10-24

# Create the jenkins user
RUN useradd -d "/var/jenkins_home" -u 1000 -m -s /bin/bash jenkins

# Create the folders and volume mount points
RUN mkdir -p /var/log/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins
VOLUME ["/var/log/jenkins", "/var/jenkins_home"]

USER jenkins

COPY jobs/ /var/jenkins_home/jobs/
RUN echo "listing preconfigured jobs:" && ls /var/jenkins_home/jobs/

CMD ["echo", "data-only container for Jenkins"]