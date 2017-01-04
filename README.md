# Java Spring APPUiO demo

This repo contains an empty Java Spring Boot project created by https://start.spring.io/ with the Spring Boot Web MVC and Spring Boot Actuator modules.

I added a simple Controller Class (src/main/java/com/arska/SpringdemoController.java) to output "Hello!" when accessing the application root instead of an error.

The build configuration in pom.xml outputs a WAR called ROOT.war that will be automatically deployed by the OpenShift 3 Source-to-Image (s2i) process for Wildfly.
You can run this on OpenShift (e.g. http://appuio.ch) using the Web-GUI ("Add to project", select Wildfly, enter a name (e.g. springdemo) and GIT URL (e.g. https://github.com/arska/springdemo.git) and "create") or CLI:
```
$ oc new-app openshift/wildfly:latest~https://github.com/arska/springdemo.git
$ oc expose service springdemo
```

You can clean everything up with
```
$ oc delete all -l app=springdemo
```

When opening the app you should see "Hello!".

You can manually add a readiness check to /health (the app has about 120s to boot after buiding and starting the pod) and you can check with pod you are hitting at /env/jboss.node.name

