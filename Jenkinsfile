pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'akshaanshs/calculator-app'
        DOCKER_TAG = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo 'Installing dependencies...'
                bat 'C:\\Python313\\python.exe -m pip install -r requirements.txt --quiet'
                echo 'Dependencies installed successfully'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                bat 'C:\\Python313\\python.exe app.py'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                bat 'C:\\Python313\\python.exe -m pytest test_app.py -v'
            }
        }

        stage('Docker Build') {
            steps {
                echo 'Building Docker image...'
                bat "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
                bat "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_IMAGE}:latest"
                echo 'Docker image built successfully'
            }
        }

        stage('Docker Test') {
            steps {
                echo 'Running app inside Docker container...'
                bat "docker run --rm ${DOCKER_IMAGE}:latest"
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing image to Docker Hub...'
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat "docker login -u %DOCKER_USER% -p %DOCKER_PASS%"
                    bat "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                    bat "docker push ${DOCKER_IMAGE}:latest"
                }
                echo 'Successfully pushed to Docker Hub'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                echo "Build Number: ${BUILD_NUMBER}"
                echo "Docker Image: ${DOCKER_IMAGE}:${DOCKER_TAG}"
                echo 'In production this would deploy to AWS or Kubernetes'
            }
        }
    }

    post {
        success {
            echo "Pipeline ${BUILD_NUMBER} completed successfully!"
            mail(
                to: 'akshaanshs@gmail.com',
                subject: "SUCCESS: Jenkins Build ${BUILD_NUMBER}",
                body: "Job: ${JOB_NAME}\nBuild: ${BUILD_NUMBER}\nDocker Image: akshaanshs/calculator-app:${BUILD_NUMBER}\nDocker Hub: https://hub.docker.com/r/akshaanshs/calculator-app\nStatus: SUCCESS\nURL: ${BUILD_URL}"
            )
        }
        failure {
            echo "Pipeline ${BUILD_NUMBER} failed!"
            mail(
                to: 'akshaanshs@gmail.com',
                subject: "FAILED: Jenkins Build ${BUILD_NUMBER}",
                body: "Job: ${JOB_NAME}\nBuild: ${BUILD_NUMBER}\nStatus: FAILED\nURL: ${BUILD_URL}console"
            )
        }
        always {
            echo 'Pipeline finished. Cleaning up...'
            bat "docker rmi ${DOCKER_IMAGE}:${BUILD_NUMBER} || exit 0"
        }
    }
}