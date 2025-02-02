pipeline {
  agent any
  stage('start docker compose') {
    steps {
      sh 'docker compose up -d'
    }
  }
  stage('sleep') {
    steps {
      sh 'sleep 10'
    }
  }
  stage('application tests') {
    steps {
      sh 'app-tests.sh'
    }
  }
}