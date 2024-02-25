FROM openjdk:17-jdk-slim

LABEL maintainer="che444 macdialloisidk@groupeisi.com"

EXPOSE 8080

ADD target/jenkins.jar jenkins.jar

ENTRYPOINT ["java", "-jar", "jenkins.jar"]