In order to run a manual maven build:
```
docker run -it --rm -v $(pwd):/opt/maven -w /opt/maven maven:3.3.3-jdk-7 mvn clean install
```