/* TODO: 
    - test stage hinzufügen
*/
pipeline {
    agent any
    }

    stages {
        stage('Lab: Unit and Integration Tests') {
            /* 
            This stage is only run when a PR is made against branch 'develop-lab'
            The purpose is to deploy the bundle to the test-lab target and run the unit- and integration tests
            Furthermore, the bundle is validated with the staging-lab target 
            */
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
                /* Validating Databricks bundle with test-lab target */
                echo 'Validating bundle with test-lab target'
                sh 'databricks bundle validate -t test-lab'

                /* Deploying Databricks bundle with test-lab target */
                echo 'Deploying bundle with test-lab target'
                sh 'databricks bundle deploy -t test-lab'

                /* Running test code */
                echo 'Running tests'
                sh 'databricks bundle run test-job -t test-lab'

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
                /* dbt parse --> braucht keinen DB  Zugriff*/
                /* dbt compile --> braucht DB  Zugriff via ENV Variable*/
                /* auf Databricks: dbt run, dbt test (als Notebook job)*/

            }
        }
        stage('Int: Unit and Integration Tests') {
            /* 
            This stage is only run when a PR is made against branch 'develop-int'
            The purpose is to deploy the bundle to the test-int target and run the unit- and integration tests
            Furthermore, the bundle is validated with the staging-int target 
            */
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
                /* Validating Databricks bundle with test-int target */
                echo 'Validating bundle with test-int target'
                sh 'databricks bundle validate -t test-int'

                /* Deploying Databricks bundle with test-int target */
                echo 'Deploying bundle with test-int target'
                sh 'databricks bundle deploy -t test-int'

                /* Running test code */
                echo 'Running tests'
                sh 'databricks bundle run test-int -t test-int'
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
            /*
            This stage is only run when a change (merge) is made to the develop-lab branch
            The purpose is to validate and deploy the bundle to the staging-lab target
            */
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
            /*
            This stage is only run when a change (merge) is made to the develop-int branch
            The purpose is to validate and deploy the bundle to the staging-int target
            */
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
            /*
            This stage is only run when a PR is made against branch 'main'
            The purpose is to validate and deploy the bundle to the test-prod target
            */
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
            /*
            This stage is only run when a change (merge) is made to the main branch
            The purpose is to validate and deploy the bundle to the prod target
            */
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
