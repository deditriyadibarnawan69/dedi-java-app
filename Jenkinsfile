pipeline {
  environment {
    DOCKER_IMAGE = 'brdcookies6969/dedi-java-app'
    dockerImage = ""
    KUBERNETES_NAMESPACE = 'dedi-namespace'
  }
  agent any
  stages {
    stage('Checkout Source') {
      steps {
	      checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[credentialsId: 'token-key-github', url: 'https://github.com/deditriyadibarnawan69/dedi-java-app.git']])
      }
    }
    stage('Build Docker Image') {
        steps {
            script {
                // Build Docker image
                sh '''
                    docker build -t $DOCKER_IMAGE .
                '''
            }
        }
    }
    stage('Docker Push') {
        steps {
            withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
            sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
            sh 'docker push $DOCKER_IMAGE'
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
