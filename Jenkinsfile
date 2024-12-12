pipeline {
  environment {
    dockerimagename = "brdcookies6969/dedi-java-app"
    dockerImage = ""
    KUBECONFIG = "${WORKSPACE}/kubeconfig"
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
    
    stage('Prepare Kubeconfig') {
            steps {
                // Mengunduh kubeconfig dari Jenkins credentials
                withCredentials([file(credentialsId: 'kubeconfig-credential-id', variable: 'KUBECONFIG_FILE')]) {
                    sh """
                    cp $KUBECONFIG_FILE ${KUBECONFIG}
                    chmod 600 ${KUBECONFIG}
                    """
                }
            }
        }
    stage('Deploy to Kubernetes') {
            steps {
                // Deploy aplikasi ke Kubernetes dengan kubectl
                sh """
                kubectl --kubeconfig=${KUBECONFIG} apply -f deployment.yaml
                """
            }
        }
  post {
        always {
            // Membersihkan file kubeconfig setelah pipeline selesai
            sh "rm -f ${KUBECONFIG}"
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
    // stage('Deploying container to Kubernetes') {
    //   steps {
    //     script {
    //       sh '''
	  //   kubectl rollout restart deployment/dedi-java-app-deploy
    //       '''
    //     }
    //   }
    // }
  }
}
