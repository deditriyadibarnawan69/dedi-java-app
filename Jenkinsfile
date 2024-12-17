pipeline {
  environment {
    dockerimagename = "brdcookies6969/dedi-java-app"
    dockerImage = ""
    KUBERNETES_NAMESPACE = 'dedi-namespace'
  }
  agent any
  stages {
    stage('Checkout Source') {
      steps {
	      checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'token-github', url: 'https://github.com/deditriyadibarnawan69/dedi-java-app.git']])
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
    
    stage('Deploy again to Kubernetes') {
            steps {
                script {
                    // Deploy to Kubernetes using kubectl
                    sh '''
                        kubectl apply -f manifest-java-app.yaml -n $KUBERNETES_NAMESPACE
                    '''
                }
            }
        }
        stage('rollout restart  Kubernetes') {
            steps {
                script {
                    // Deploy to Kubernetes using kubectl
                    sh '''
                        kubectl rollout restart deployment/dedi-java-app-deploy -n $KUBERNETES_NAMESPACE
                    '''
                }
            }
        }
  } 
  post {
        always {
            // Clean up if necessary, for example, remove the Docker image locally
            sh 'docker rmi $DOCKER_IMAGE'
        }
    }
}
