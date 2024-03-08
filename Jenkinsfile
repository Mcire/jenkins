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
                    sh "docker build -t che444/jenkins-che:latest ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker login -u your-docker-username -p your-docker-password"
                    sh "docker push che444/jenkins-che:latest"
                }
            }
        }
    }
}
