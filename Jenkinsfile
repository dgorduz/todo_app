pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        AWS_ID = '548126811902'
        ECR_REPOSITORY = 'todo-app'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    // def dockerImage = docker.build("todo_app_from_jenkins:latest")
                    sh 'docker build -t todo_app_from_jenkins:latest .'
                }
            }
        }

        stage('Push to ECR') {
            steps {
                script {
                        // Authenticate Docker to ECR
                        def ecrLogin = sh(script: "aws ecr get-login-password --region ${AWS_REGION}", returnStatus: true)
                        if (ecrLogin == 0) {
                            sh "docker login --username AWS --password-stdin ${AWS_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
                        } else {
                            error("Failed to authenticate Docker to ECR")
                        }
                        // Tag Docker image
                        sh "docker tag ${ECR_REPOSITORY}:latest ${AWS_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:latest"

                        // Push Docker image to ECR
                        sh "docker push ${AWS_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_REPOSITORY}:latest"
                    }
                }
            }
        }
    }
