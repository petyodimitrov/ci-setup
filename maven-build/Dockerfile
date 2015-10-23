FROM maven:3.3.3-jdk-7
MAINTAINER Petyo Dimitrov

# Create the folders and volume mount points
RUN mkdir -p /root/.m2
COPY maven-settings.xml /root/.m2/settings.xml

CMD ["echo", "image for maven jobs started by jenkins"]
