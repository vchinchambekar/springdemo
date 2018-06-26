# use the apache maven as base image, including java and maven
FROM maven:3.5-jdk-8-alpine

# take some responsibility
MAINTAINER Aarno Aukia <aarno.aukia@vshn.ch>

# run the build process in this directory
WORKDIR /opt/app-root/src/

# add maven config and application source as root
ADD ./pom.xml /opt/app-root/src/
ADD src /opt/app-root/src/src

# chmod all the data and directories before dropping root privileges
RUN chown -R 1001 /opt/app-root/

# run as normal user
USER 1001

# change config to output standalone jar
RUN sed -i "s/war/jar/" /opt/app-root/src/pom.xml

# compile java code using maven
ENV MAVEN_HOME /opt/app-root/src/
ENV M2_HOME /opt/app-root/src/
RUN mvn clean install

# copy the resulting jar to the parent directory
RUN cp -a  /opt/app-root/src/target/ROOT*.jar /opt/app-root/springdemo.jar

# run the jar file
CMD java -Xmx64m -Xss1024k -jar /opt/app-root/springdemo.jar

# the application will listen on this port
EXPOSE 8080

