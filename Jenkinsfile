pipeline {
    agent any

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
                bat 'python --version'
                bat 'C:\\Python313\\python.exe app.py'
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
            mail(
                to: 'akshaanshs@gmail.com',
                subject: "✅ SUCCESS: Jenkins Build #${BUILD_NUMBER}",
                body: """
Hi Akshaansh,

Your Jenkins pipeline ran successfully!

Job Name   : ${JOB_NAME}
Build Number: ${BUILD_NUMBER}
Branch     : ${GIT_BRANCH}
Status     : SUCCESS

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

Job Name   : ${JOB_NAME}
Build Number: ${BUILD_NUMBER}
Branch     : ${GIT_BRANCH}
Status     : FAILED

Check the console output for errors:
${BUILD_URL}console

Please fix the issue and push again.

- Jenkins
                """
            )
        }
        always {
            echo 'Pipeline finished. Cleaning up...'
        }
    }
}