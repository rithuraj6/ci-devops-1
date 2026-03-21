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
         stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                        sh 'mvn sonar:sonar'
               
                }

            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time:2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
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

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'docker-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
            }
        }

        stage('Docker Push') {
            steps {
                sh 'docker push $DOCKER_IMAGE:${BUILD_NUMBER}'
            }
        }

        stage('Docker Logout') {
            steps {
                sh 'docker logout'
            }
        }
    }
}
