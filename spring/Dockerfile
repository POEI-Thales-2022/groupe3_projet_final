FROM openjdk:8u111-jdk-alpine
VOLUME /tmp
ADD api-8080.jar app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]