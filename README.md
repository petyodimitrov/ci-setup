Example of CI setup for building Java applications that has been "dockerized". 

It includes Jenkins and Nexus container images (each with a data container image) as well as a Maven.
The preconfigured Jenkins job pulls the application's source code from GitHub, starts an ephimeral Maven container that builds, packages and deploys the application to Nexus.

Demo is tested with: 
* Windows 7 
* Docker Toolkit 1.8.3 (https://github.com/docker/toolbox/releases/download/v1.8.3/DockerToolbox-1.8.3.exe), including
* VirtualBox 5.0.6
    * Docker engine 1.8.3
    * Docker API 1.20
    * Docker client for Windows
    * Boot2Docker 4.1.10
    * Kitematic 0.8.7 alpha (https://github.com/kitematic/kitematic/releases)
* Docker Compose (https://github.com/docker/compose/releases/tag/1.5.0rc1)	

**COMMANDS:**
```	
docker-machine create --driver virtualbox --virtualbox-memory 12288 --virtualbox-cpu-count 2  --engine-insecure-registry localhost:9500 default
docker-machine stop default
VBoxManage modifyvm "default" --vram 128
docker-machine start default
docker-machine ip default
docker-machine env --shell powershell default | Invoke-Expression
```	
**URLS**
Infrastructure:
* jenkins:  http://192.168.99.100:9080/
* nexus:    http://192.168.99.100:9081/
* registry: http://192.168.99.100:9082/

Runtime:
* spring-music:  http://192.168.99.100
* nginx:         http://192.168.99.100/nginx_status
* app-node-1:    http://192.168.99.100:8180/manager (admin: passw0rd)
* app-node-2:    http://192.168.99.100:8280/manager (admin: passw0rd)
* Kibana:        http://192.168.99.100:8081
* Elasticsearch: http://192.168.99.100:8082
* Elasticsearch: http://192.168.99.100:8082/_status?pretty
* Logspout:      http://192.168.99.100:8083/logs

**PROBLEMS:**
* docker toolbox: virtual box update corrupted the vboxdrv system driver and had to reinstall it and set VBoxManage to PATH (probably due to incorrect paths in registry)
* docker toolbox: need to manually set msysgit's ssh executable to PATH
* environment variables sometimes get lost and need to be reset
* docker cli can be run via:
	- standard cmd
	- powershell (kitematic)
	- git-bash (docker quickstart terminal)

**COMMANDS USED DURING SETUP:**
```	
# jenkins
docker run --name jenkins-config -v /var/jenkins_home --entrypoint /bin/echo jenkins data-only container for jenkins
docker run --name jenkins --volumes-from jenkins-config -P jenkins

# backup data container's data to host
docker run --rm --volumes-from jenkins-config busybox ls /var/jenkins_home/
docker run --rm --volumes-from jenkins-config -v /c/Users/Petyo:/backup busybox tar zcvf /backup/jenkins-backup.tar /var/jenkins_home/
docker run --rm --volumes-from jenkins-config -v /c/Users/Petyo:/backup busybox tar zxvf /backup/jenkins-backup.tar /

# copy files:
docker cp jenkins-config:/file-to-copy-from-container .
docker exec -i jenkins-config sh -c 'cat > /file-to-copy-to-container' < local-file

# nexus
docker run -d --name nexus-data sonatype/nexus:2.11.4-01 echo "data-only container for Nexus"
docker run -d -p 9081:8081 --name nexus --volumes-from nexus-data sonatype/nexus:2.11.4-01

# docker registry with storage on docker host due to NFS bug
docker run -d -p 5000:5000 --restart=always -v /var/lib/registry:/var/lib/registry --name registry registry:2
docker run -d --link registry:registry -e ENV_DOCKER_REGISTRY_HOST=registry -e ENV_DOCKER_REGISTRY_PORT=5000 -e ENV_MODE_BROWSE_ONLY=true -p 8090:80 --name registry-ui konradkleine/docker-registry-frontend:v2

# maven build
docker run -it --rm -v "$(pwd)":/opt/maven -w /opt/maven maven:3.3.3-jdk-7 mvn clean install

# jenkins plugins
https://updates.jenkins-ci.org/download/plugins/authentication-tokens/1.2/authentication-tokens.hpi
https://updates.jenkins-ci.org/download/plugins/git/2.4.0/git.hpi
https://updates.jenkins-ci.org/download/plugins/git-client/1.19.0/git-client.hpi
https://updates.jenkins-ci.org/download/plugins/scm-api/0.2/scm-api.hpi

# container with access to docker host
docker run -ti --rm -v /var/run/docker.sock:/var/run/docker.sock:ro -v /usr/local/bin/docker:/usr/bin/docker:ro --privileged=true ubuntu:14.04 /bin/bash

# jenkins command line API
java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -s http://127.0.0.1:8080 install-plugin git docker-custom-build-environment

# nexus REST API
http://192.168.99.100:9081/service/local/artifact/maven/redirect?r=snapshots&g=org.cloudfoundry.samples&a=spring-music&v=1.0-SNAPSHOT&p=war
http://192.168.99.100:9081/service/local/artifact/maven/redirect?r=snapshots&g=org.cloudfoundry.samples&a=spring-music&v=1.0-SNAPSHOT&p=zip&c=static
http://192.168.99.100:9081/service/local/artifact/maven/redirect?r=snapshots&g=org.cloudfoundry.samples&a=spring-music&v=1.0-SNAPSHOT&p=jar&c=test-jar-with-dependencies

# install docker compose on jenkins
apt-get update && apt-get install -y curl
curl -L https://github.com/docker/compose/releases/download/1.5.0rc1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# remove dangling images
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")

# run spock tests
java -XX:-UseSplitVerifier -cp target/spring-music-1.0-SNAPSHOT-test-jar-with-dependencies.jar org.junit.runner.JUnitCore org.cloudfoundry.samples.music.config.geb.DemoSpec

# run selenium image
docker run -it --rm -p 5900:5900 -p 4444:4444 se bash /test.sh

# function that waits for proxy to start
#!/bin/bash -e
function wait_for_proxy() {
   COUNTER=1
   FAILED=0
   until $(curl --output /dev/null --silent --head --fail $1); do
      printf '.'
      sleep 5
      let COUNTER=COUNTER+1 
      if [ $COUNTER -gt $2 ]; then 
	     return 1
      fi
   done
   return 0
}
```	

**NOTES TO SELF:**
* dangling volumes can be forgotten if -v is not used upon deletion (pending volume management improvement)
* for now kitematic's support on windows is alpha and lacks multi-docker machine support
* when building with external files beware of EOL
* nexus rest API
