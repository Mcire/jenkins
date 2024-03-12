# Jenkins ci/cd
The Maven Spring Boot project presented here aims to establish a CI/CD (Continuous Integration/Continuous Deployment)
pipeline using Jenkins and Docker. This approach automates the development, testing and deployment processes, guaranteeing fast, efficient application delivery.

## Objectives:
- Configure Jenkins: Install Jenkins and the necessary plugins for Docker and Maven. Set up credentials to access the Maven repository and Docker Hub.
- Docker Hub: Configure Docker Hub to trigger a webhook each time a new image is pushed. Configure Jenkins to trigger deployment in response to this webhook.
- Docker: Ensure that Docker is installed and running correctly. Create an appropriate Dockerfile to successfully containerize the Spring Boot application.
- Jenkins Pipeline: Create a new Jenkins job that monitors the project's Git repository. Use a Jenkinsfile to define the steps involved in building the Maven project, creating the Docker image and publishing it to Docker Hub.
- Spring Boot project: Creation of a Spring Boot project exposing an endpoint at /api/jenkins. Inclusion of a Jenkinsfile to describe the steps involved in building, testing and deploying the application. Add a Dockerfile to create the application's Docker image.

# installation
For this project, we prefer to use a Jenkins docker image.
To do so, go to this link [jenkins installation](https://github.com/jenkinsci/docker/blob/master/README.md#connecting-agents)
After installation to start jenkins type the command : 
```docker 
docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 --restart=on-failure jenkins/jenkins:lts-jdk17
```
# Configuration
## Go to jenkins to create the pipline ci/cd
For pipline creation and jenkins configuration, please follow [this video](https://youtu.be/PKcGy9oPVXg?si=IVLPtd67xwxfGm3f)
## git hub configuration
go to git hub to configure Webhooks. 
It is important to enter the Payload URL value correctly.
For a better understanding, [follow the video ](https://youtu.be/PKcGy9oPVXg?si=IVLPtd67xwxfGm3f)

# Jenkinsfile
```jenkins
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh "/var/jenkins_home/tools/hudson.tasks.Maven_MavenInstallation/Maven/bin/mvn clean package"
            }
        }
        stage('Test') {
            steps {
                sh "/var/jenkins_home/tools/hudson.tasks.Maven_MavenInstallation/Maven/bin/mvn test"
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'which docker || (echo "Docker not found in PATH"; exit 1)'
                    sh "docker build -t che444/jenkins-che ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub-pwd', variable: 'dockerhubpwd')]){
                    sh "docker login -u che444 -p ${dockerhubpwd}"
                    sh "docker push che444/jenkins-che"
                }
            }
        }
    }
}
```
This Jenkins pipeline is designed to automate the following steps:

- **Build**: This step cleans up the Maven project and package, generating the build artifacts. This ensures that the code is compiled and ready for testing and deployment.

- **Test**: In this step, unit tests are run to verify the quality and functionality of the code. This ensures that changes made to the code have not introduced any new problems.

- **Build Docker Image**: This step uses Docker to build a Docker image from the previously generated artifacts. The Docker image is generally used to encapsulate the application in an isolated, portable environment.

- **Push Docker Image** : Finally, this step authenticates the user on Docker Hub using secure credentials stored in Jenkins. Next, it pushes the previously built Docker image onto Docker Hub. This makes the image available for deployment on other environments or for sharing with other users.

- # Dockerfile
``` docker
FROM openjdk:17-jdk-slim

LABEL maintainer="che444 macdialloisidk@groupeisi.com"

EXPOSE 8080

ADD target/jenkins-che.jar jenkins-che.jar

ENTRYPOINT ["java", "-jar", "jenkins-che.jar"]
```
this Dockerfile builds a Docker image containing a Java application, ready to be run in a Docker container, exposing port 8080 for incoming connections.

# Result
## pipline jenkins
![Screenshot 2024-02-25 221150](https://github.com/Mcire/jenkins/assets/95756307/ce39124a-3ecb-4674-9971-5b727a70f771)
