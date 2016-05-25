#!/bin/bash

echo starting services...
/opt/bin/entry_point.sh > /dev/null 2&>1 &
echo started

echo downloadnig tests...
wget -O /tmp/spring-music-test-jar-with-dependencies.jar "http://${NEXUS_HOST}:${NEXUS_PORT}/service/local/artifact/maven/redirect?r=snapshots&g=org.cloudfoundry.samples&a=spring-music&v=1.0-SNAPSHOT&p=jar&c=test-jar-with-dependencies"
echo downloaded

echo running tests...
java -cp /tmp/spring-music-test-jar-with-dependencies.jar org.junit.runner.JUnitCore org.cloudfoundry.samples.music.config.geb.DemoSpec