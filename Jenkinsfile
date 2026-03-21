pipeline {
    agent {
        label 'docker-agent'
    }

    environment {
        DOCKER_IMAGE = "rithuraj6/ci-cd-devops"
    }

    stages {

        stage('Build') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t ci-cd-devops:${BUILD_NUMBER} .'
            }
        }

        stage('Docker Tag') {
            steps {
                sh 'docker tag ci-cd-devops:${BUILD_NUMBER} $DOCKER_IMAGE:${BUILD_NUMBER}'
            }
        }

        stage('Docker Push') {
            steps {
                sh 'docker push $DOCKER_IMAGE:${BUILD_NUMBER}'
            }
        }
    }
}
