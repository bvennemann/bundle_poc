pipeline {
    agent {
        dockerfile true
    }

    stages {
        stage('Unit and Integration Tests') {
            /*
            agent {
                docker {
                    image 'python:3-alpine'
                }
            }
            */
            when {
                /* only run when a PR is made against branch 'develop' */
                changeRequest target: 'develop'

            }
            environment {
                ARM_TENANT_ID = credentials('LAB_AZURE_SP_TENANT_ID')
                ARM_CLIENT_ID = credentials('LAB_AZURE_SP_APPLICATION_ID')
                ARM_CLIENT_SECRET = credentials('LAB_AZURE_SP_CLIENT_SECRET') 
            }
            steps {
                echo 'Running unit tests'
                echo 'Running integration tests'
                echo 'Install the Databricks CLI'

                sh 'databricks bundle validate'

            }
        }
        stage('Deploy to staging'){
            when {
                /* only run when a change (merge) is made to the develop branch */
                branch 'develop'
            }
            steps {
                echo 'Deploying to staging target'
            }
        }
        stage('Tests prior to release in prod'){
            when {
                /* only run when a PR is made against branch 'main' */
                changeRequest target: 'main'
            }
            steps {
                echo 'Running tests prior to prod release'
            }
        }
        stage('Deploy to prod') {
            when {
                /* only run when a change (merge) is made to the main branch */
                branch 'main'
            }
            steps {
                echo 'Deploying to prod target....'
            }
        }
    }
}
