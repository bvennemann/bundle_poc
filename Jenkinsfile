pipeline {
    agent {
        /*dockerfile true */
        docker {
            image 'bundle_poc_image:latest'
            registryUrl 'localhost:5000/bundle_poc_image'
        }
    }

    stages {
        stage('Lab: Unit and Integration Tests') {
            when {
                /* only run when a PR is made against branch 'develop-lab' */
                changeRequest target: 'develop-lab'
            }
            environment {
                /* Set environment for Lab workspace */
                ARM_TENANT_ID = credentials('LAB_AZURE_SP_TENANT_ID')
                ARM_CLIENT_ID = credentials('LAB_AZURE_SP_APPLICATION_ID')
                ARM_CLIENT_SECRET = credentials('LAB_AZURE_SP_CLIENT_SECRET') 
            }
            steps {
                echo 'Running unit tests'
                /* TODO: Fix spark session for testing */
                /* Run pytest */
                /* sh 'pytest --junitxml=test-unit.xml' */
                
                /* Run integration tests */
                echo 'Running integration tests'
                /* Deploy with target test-lab and run workflow? */

                /* Validate Databricks bundle with staging target */
                echo 'Validate Bundle with staging target'
                sh 'databricks bundle validate -t staging-lab'

                /* Validate dbt project */
                /* dbt parse */

            }
        }
        stage('Int: Unit and Integration Tests') {
            when {
                /* only run when a PR is made against branch 'develop-int' */
                changeRequest target: 'develop-int'
            }
            environment {
                /* Set environment for Lab workspace */
                ARM_TENANT_ID = credentials('INT_AZURE_SP_TENANT_ID')
                ARM_CLIENT_ID = credentials('INT_AZURE_SP_APPLICATION_ID')
                ARM_CLIENT_SECRET = credentials('INT_AZURE_SP_CLIENT_SECRET') 
            }
            steps {
                echo 'Running unit tests'
                /* TODO: Fix spark session for testing */
                /* Run pytest */
                /* sh 'pytest --junitxml=test-unit.xml' */
                
                /* Run integration tests */
                echo 'Running integration tests'
                /* Deploy with target test-int and run workflow? */

                /* Validate Databricks bundle with staging target */
                echo 'Validate Bundle with staging target'
                sh 'databricks bundle validate -t staging-int'

                /* Validate dbt project */
                /* dbt parse */

            }
        }
        stage('Lab: Deploy to Lab with staging config'){
            when {
                /* only run when a change (merge) is made to the develop-lab branch */
                branch 'develop-lab'
            }
            environment {
                /* Set environment for Lab workspace */
                ARM_TENANT_ID = credentials('LAB_AZURE_SP_TENANT_ID')
                ARM_CLIENT_ID = credentials('LAB_AZURE_SP_APPLICATION_ID')
                ARM_CLIENT_SECRET = credentials('LAB_AZURE_SP_CLIENT_SECRET') 
            }
            steps {
                sh 'databricks bundle validate -t staging-lab'
                sh 'databricks bundle deploy -t staging-lab'
            }
        }
        stage('Int: Deploy to Int with staging config'){
            when {
                /* only run when a change (merge) is made to the develop-int branch */
                branch 'develop-int'
            }
            environment {
                /* Set environment for Int workspace */
                ARM_TENANT_ID = credentials('INT_AZURE_SP_TENANT_ID')
                ARM_CLIENT_ID = credentials('INT_AZURE_SP_APPLICATION_ID')
                ARM_CLIENT_SECRET = credentials('INT_AZURE_SP_CLIENT_SECRET') 
            }
            steps {
                sh 'databricks bundle validate -t staging-int'
                sh 'databricks bundle deploy -t staging-int'
            }
        }
        stage('Factory: Prerelease tests'){
            when {
                /* only run when a PR is made against branch 'main' */
                changeRequest target: 'main'
            }
            environment {
                /* Set environment for Factory workspace */
                ARM_TENANT_ID = credentials('FACTORY_AZURE_SP_TENANT_ID')
                ARM_CLIENT_ID = credentials('FACTORY_AZURE_SP_APPLICATION_ID')
                ARM_CLIENT_SECRET = credentials('FACTORY_AZURE_SP_CLIENT_SECRET') 
            }
            steps {
                echo 'Validate bundle with prod target'
                sh 'databricks bundle validate -t prod'
                echo 'Run unit tests'
            }
        }
        stage('Factory: Deploy to Factory with prod config') {
            when {
                /* only run when a change (merge) is made to the main branch */
                branch 'main'
            }
            environment {
                /* Set environment for Factory workspace */
                ARM_TENANT_ID = credentials('FACTORY_AZURE_SP_TENANT_ID')
                ARM_CLIENT_ID = credentials('FACTORY_AZURE_SP_APPLICATION_ID')
                ARM_CLIENT_SECRET = credentials('FACTORY_AZURE_SP_CLIENT_SECRET') 
            }
            steps {
                /* Validate and deploy Databricks bundle with prod target */
                echo 'Deploy bundle to prod target'
                sh 'databricks bundle validate -t prod'
                sh 'databricks bundle deploy -t prod'
            }
        }
    }
}
