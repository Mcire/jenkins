FROM openjdk:17-jdk-slim

LABEL maintainer="che444 macdialloisidk@groupeisi.com"

EXPOSE 8080

ADD target/jenkins-che.jar jenkins-che.jar

ENTRYPOINT ["java", "-jar", "jenkins-che.jar"]