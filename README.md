# Java Spring APPUiO demo

This repo contains an empty Java Spring Boot project created by https://start.spring.io/ with the Spring Boot Web MVC and Spring Boot Actuator modules.

I added a simple Controller Class (src/main/java/com/arska/SpringdemoController.java) to output "Hello!" when accessing the application root instead of an error.

The build configuration in pom.xml outputs a WAR called ROOT.war that will be automatically deployed by the OpenShift 3 Source-to-Image (s2i) process for Wildfly.
You can run this on OpenShift (e.g. http://appuio.ch) using the Web-GUI ("Add to project", select Wildfly, enter a name (e.g. springdemo) and GIT URL (e.g. https://github.com/appuio/springdemo.git) and "create") or CLI:
```
$ oc new-app openshift/wildfly:latest~https://github.com/appuio/springdemo.git
$ oc expose service springdemo
```

This repo also contains an openshift template springdemo-template.json that you can use to instantiate the project, either manually though copy-pasting it to the Web-GUI ("Add to project", "Import YAML / JSON") or through the CLI:
```
$ oc new-app -f springdemo-template.json
```

Note that due to a race condition when instantiating the template (https://github.com/openshift/origin/issues/4518) the first build run can fail at pushing the resuling container ("Error pushing to registry: Authentication is required"), just start a new build in the Web-GUI oder CLI (oc new-build springdemo).

When opening the app you should see "Hello!".

You can check out the healthcheck-page at /health, the name of the pod at /env/jboss.node.name and other spring mappings at /mappings

You can clean everything up with
```
$ oc delete all -l app=springdemo
```

For more information about templates: see https://docs.openshift.com/container-platform/latest/dev_guide/templates.html

