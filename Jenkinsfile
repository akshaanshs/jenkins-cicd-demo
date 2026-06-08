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
                echo 'Installing dependencies from requirements.txt...'
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
                echo "Building Docker image: ${DOCKER_IMAGE}:${DOCKER_TAG}"
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
                echo "Pushing image to Docker Hub..."
                bat "docker push ${DOCKER_IMAGE}:${DOCKER_TAG}"
                bat "docker push ${DOCKER_IMAGE}:latest"
                echo "Successfully pushed ${DOCKER_IMAGE}:${DOCKER_TAG} to Docker Hub"
                echo "View at: https://hub.docker.com/r/${DOCKER_IMAGE}"
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                echo "Build Number: ${BUILD_NUMBER}"
                echo "Branch: ${GIT_BRANCH}"