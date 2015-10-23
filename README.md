Example of CI setup for building Java applications that has been "dockerized". 

It includes Jenkins and Nexus container images (each with a data container image) as well as a Maven.
The preconfigured Jenkins job pulls the application's source code from GitHub, starts an ephimeral Maven container that builds, packages and deploys the application to Nexus.