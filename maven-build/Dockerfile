FROM maven:3.3.3-jdk-7
MAINTAINER Petyo Dimitrov
ENV REFRESHED_AT 2015-10-24

# Create the folders and volume mount points
RUN mkdir -p /root/.m2
COPY maven-settings.xml /root/.m2/settings.xml

CMD ["echo", "image for maven jobs started by jenkins"]
