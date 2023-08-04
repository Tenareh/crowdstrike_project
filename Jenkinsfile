// Jenkinsfile

pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from the Git repository)
                git "https://github.com/etamarah/crowdstrike_project"
            }
        }
        
        stage('Build Docker Image') {
            environment {
                DOCKERHUB_USERNAME = credentials('etamarah')
                DOCKERHUB_PASSWORD = credentials('dockerhub-password')
                DOCKER_IMAGE_NAME = 'etamarah/flask_img'
                DOCKER_IMAGE_TAG = 'latest'
            }



            steps {
                // Build the Docker image and push it to Docker Hub
                script {
                    docker.build("etamarah/flask_img:latest", '.')
                    docker.withRegistry("https://index.docker.io/v2/", "docker-hub-credentials") {
                        docker.push("etamarah/flask_img:latest")
                    }
                }
            }
        }
        
        stage('Deploy with Terraform') {
            steps {
                // Deploy the Flask application using Terraform
                script {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                // Deploy Kubernetes resources using Ansible
                ansiblePlaybook(playbook: 'deploy.yml', inventory: 'localhost,')
            }
        }
    }
    
    post {
        always {
            // Cleanup after deployment
            script {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}
