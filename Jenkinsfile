pipeline {
    agent {
            docker {
                image 'docker:dind'
                args '-v /var/run/docker.sock:/var/run/docker.sock'
            }
    }
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
