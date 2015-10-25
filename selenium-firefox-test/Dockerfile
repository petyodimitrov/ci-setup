FROM selenium/standalone-firefox-debug:2.48.1
MAINTAINER Petyo Dimitrov
ENV REFRESHED_AT 2015-10-24

COPY test.sh /test.sh
RUN chmod +x /test.sh

CMD ["echo", "image for selenium test runs started by jenkins"]