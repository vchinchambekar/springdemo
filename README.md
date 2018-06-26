# Java Spring APPUiO demo

This repo contains an empty Java Spring Boot project created by https://start.spring.io/ with the Spring Boot Web MVC and Spring Boot Actuator modules.

I added a simple Controller Class (src/main/java/com/arska/SpringdemoController.java) to output "Hello!" when accessing the application root instead of an error.

The build configuration in pom.xml outputs a WAR called ROOT.war that will be automatically deployed by the OpenShift 3 Source-to-Image (s2i) process for JBoss.
You can run this on OpenShift (e.g. http://appuio.ch) using the Web-GUI ("Add to project", select "JBoss Web Server 3.1 Apache Tomcat 8" Template, enter a name (e.g. springdemo) and GIT URL (e.g. https://github.com/appuio/springdemo.git) and "create") or deploy via the CLI:
```
oc new-app openshift/jboss-webserver31-tomcat8-openshift:1.1~https://github.com/appuio/springdemo.git
oc patch bc/springdemo -p '{"spec":{"resources":{"limits":{"memory":"500Mi"}}}}'
oc patch dc/springdemo -p '{"spec":{"template":{"spec":{"containers":[{"name":"springdemo","resources":{"limits":{"memory": "500Mi"}}}]}}}}'
oc cancel-build springdemo
oc start-build springdemo
oc expose service springdemo
```

As you can see we need to adjust the RAM ressource limit for the build and deployment as the default 256MB is too tight for JBoss.

This repo also contains an openshift template springdemo-template.json that you can use to instantiate the project including proper limits and health checks, either manually though copy-pasting it to the Web-GUI ("Add to project", "Import YAML / JSON") or through the CLI:
```
oc new-app -f https://raw.githubusercontent.com/appuio/springdemo/master/springdemo-template.json -p APPNAME=springdemo
```

Note that due to a race condition when instantiating the template (https://github.com/openshift/origin/issues/4518) the first build run might fail at pushing the resuling container ("Error pushing to registry: Authentication is required"), just start a new build in the Web-GUI oder CLI (oc new-build springdemo).

When opening the app URL you should see "Hello!".

You can check out the healthcheck-page at /actuator/health

You can clean everything up with
```
$ oc delete all -l app=springdemo
```

For more information about templates: see https://docs.openshift.com/container-platform/latest/dev_guide/templates.html

You can also build/run this example locally using docker:
```
docker build -t springdemo .
docker run -p 8080:8080 springdemo
```
The application is then accessible at http://127.0.0.1:8080/

And you can of course also use the Docker builder on OpenShift:
```
oc new-app --strategy=docker https://github.com/appuio/springdemo.git
oc expose service springdemo
```

