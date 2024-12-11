pipeline {
  environment {
    dockerimagename = "brdcookies6969/dedi-java-app"
    dockerImage = ""
  }
  agent any
  stages {
    stage('Checkout Source') {
      steps {
	git branch: 'main',
	    credentialsId: 'token-github',
            url: 'https://github.com/deditriyadibarnawan69/dedi-java-app.git'
      }
    }
    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }
    stage('Pushing Image') {
      environment {
          registryCredential = 'dockerhub-credentials'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }
    stage('Deploying container to Kubernetes') {
      steps {
        script {
          sh '''
	    kubectl apply -f manifest-java-app.yaml
          '''
        }
      }
    }
  }
}
