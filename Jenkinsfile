pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out code from GitHub...'
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo 'Building the application...'
                bat 'python --version'
                bat 'python app.py'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                bat 'C:\\Python313\\python.exe -m pytest test_app.py -v'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying application...'
                echo "Build Number: ${BUILD_NUMBER}"
                echo "Branch: ${GIT_BRANCH}"
                echo "Workspace: ${WORKSPACE}"
                echo "Job Name: ${JOB_NAME}"
                echo 'Deploy step would go here in production'
            }
        }
    }

    post {
        success {
            echo "Pipeline #${BUILD_NUMBER} completed successfully!"
        }
        failure {
            echo "Pipeline #${BUILD_NUMBER} failed! Check the logs."
        }
        always {
            echo 'Pipeline finished. Cleaning up...'
        }
    }
}