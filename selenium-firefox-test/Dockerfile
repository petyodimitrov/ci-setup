FROM selenium/standalone-firefox-debug:2.48.1
MAINTAINER Petyo Dimitrov
ENV REFRESHED_AT 2016-05-24

ENV NEXUS_HOST nexus
ENV NEXUS_PORT 8081

COPY test.sh wait.sh /
RUN chmod +x /test.sh /wait.sh

RUN apt-get update -y && \
  apt-get install curl -y

CMD ["echo", "image for selenium test runs started by jenkins"]