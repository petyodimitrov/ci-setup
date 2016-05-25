FROM maven:3.3.9-jdk-7
MAINTAINER Petyo Dimitrov
ENV REFRESHED_AT 2016-05-24

# create directories and volume mount points
RUN mkdir -p /root/.m2
COPY maven-settings.xml /root/.m2/settings.xml

CMD ["echo", "image for maven jobs started by jenkins"]
