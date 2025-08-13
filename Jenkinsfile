pipeline {
    agent any

    environment {
        DOCKER_HUB_USER = 'rashmimurthi'
    }

    stages {
        stage('Clone Code') {
            steps {
                git branch: 'main', url: 'https://github.com/rashmi-murthi/Devops-Project.git'
            }
        }

        stage('JUnit Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Build Maven Artifacts') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build and Tag Docker Image') {
            steps {
                sh "docker build -t dev-app ."
                sh "docker tag dev-app ${DOCKER_HUB_USER}/dev-app:latest"
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHub', usernameVariable: 'DOCKER_HUB_USER_CRED', passwordVariable: 'DOCKER_HUB_PASS')]) {
                    sh "docker login -u ${DOCKER_HUB_USER_CRED} -p ${DOCKER_HUB_PASS}"
                    sh "docker push ${DOCKER_HUB_USER}/dev-app:latest"
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                sh "docker rm -f cnt-japp || true"
                sh "docker run -d --name cnt-japp -p 8081:8080 ${DOCKER_HUB_USER}/dev-app:latest"
                sh "docker image prune -af"
            }
        }
    }
}
