/*
 * Jenkins is an open-source automation server used for Continuous Integration (CI) and Continuous Deployment (CD).
 * It helps developers automate the building, testing, and deployment of applications.
 *
 * Key Features of Jenkins:
 * - Automates software development processes (CI/CD pipelines).
 * - Supports integration with various tools and plugins.
 * - Can run builds, execute scripts, and deploy applications.
 * - Allows parallel execution of jobs and distributed builds.
 * - Provides monitoring and logging of pipeline execution.
 *
 * Jenkinsfiles are used to define pipeline workflows as code, making builds reproducible and manageable.
 */

pipeline {
  // 'agent any' means this pipeline can run on any available Jenkins agent
  agent any 

  // Stages from pipeline
  stages {
    // First stage: Start Docker containers using Docker Compose
    stage('Start Docker Compose') {
      steps {
        // Runs 'docker compose up -d' to start services in detached mode
        sh 'docker compose up -d'
      }
    }

    // Second stage: Introduces a delay to allow services to start properly
    stage('Sleep') {
      steps {
        // Waits for 10 seconds before moving to the next stage
        sh 'sleep 10'
      }
    }

    stage('Sonarqube validation') {
      steps {
        script {
          SONAR_SCANNER_HOME = tool 'sonar-scanner';
        }

        withSonarQubeEnv('sonar-server') {
          sh "${SONAR_SCANNER_HOME}/bin/sonar-scanner -Dsonar.projectKey=redis-app -Dsonar.sources=. -Dsonar.host.url${env.SONAR_HOST_URL} -Dsonar.login=${env.SONAR_AUTH_TOKEN}"
        }
      }
    }

    stage('Wait quality gate') {
      steps {
        sh 'sleep 10'
        waitForQualityGate abortPipeline: true
      }
    }

    // Third stage: Runs application tests
    stage('Application Tests') {
      steps {
        sh 'chmod +x app-tests.sh'
        // Executes a script named 'app-tests.sh' to test the application
        sh './app-tests.sh'
      }
    }
  }
}
