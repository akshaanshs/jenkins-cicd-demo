pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'calculator-app'
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
                echo "Docker image built successfully"
            }
        }

        stage('Docker Test') {
            steps {
                echo 'Running app inside Docker container...'
                bat "docker run --rm ${DOCKER_IMAGE}:latest"
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                echo "Build Number: ${BUILD_NUMBER}"
                echo "Branch: ${GIT_BRANCH}"
                echo "Docker Image: ${DOCKER_IMAGE}:${DOCKER_TAG}"
                echo 'In production this would push to Docker Hub or AWS ECR'
            }
        }
    }

    post {
        success {
            echo "Pipeline #${BUILD_NUMBER} completed successfully!"
            mail(
                to: 'akshaanshs@gmail.com',
                subject: "✅ SUCCESS: Jenkins Build #${BUILD_NUMBER}",
                body: """
Hi Akshaansh,

Your Jenkins pipeline ran successfully!

Job Name    : ${JOB_NAME}
Build Number: ${BUILD_NUMBER}
Branch      : ${GIT_BRANCH}
Docker Image: calculator-app:${BUILD_NUMBER}
Status      : SUCCESS

Check the full build at:
${BUILD_URL}

- Jenkins
                """
            )
        }
        failure {
            echo "Pipeline #${BUILD_NUMBER} failed! Check the logs."
            mail(
                to: 'akshaanshs@gmail.com',
                subject: "❌ FAILED: Jenkins Build #${BUILD_NUMBER}",
                body: """
Hi Akshaansh,

Your Jenkins pipeline has FAILED!

Job Name    : ${JOB_NAME}
Build Number: ${BUILD_NUMBER}
Branch      : ${GIT_BRANCH}
Status      : FAILED

Check the console output for errors:
${BUILD_URL}console

Please fix the issue and push again.

- Jenkins
                """
            )
        }
        always {
            echo 'Pipeline finished. Cleaning up...'
            bat "docker rmi ${DOCKER_IMAGE}:${BUILD_NUMBER} || exit 0"
        }
    }
}