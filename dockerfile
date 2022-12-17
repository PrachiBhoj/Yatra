#pull tomcat latest image from dockerhub
FROM tomcat:8.0.51-jre8-alpine
MAINTAINER prachideore19@gmail.com
#Copy Jar file to container
COPY ./target/yatra*.jar /usr/local/tomcat/webapps
EXPOSE 8080 80
USER yatraapp
WORKDIR /usr/local/tomcat/webapps
CMD ["catalina.sh","run"]
