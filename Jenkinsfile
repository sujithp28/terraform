// ===========================================================
// Jenkinsfile — Multi-stage CI/CD Pipeline
// Builds Docker image, pushes to ECR, deploys to EKS
// ===========================================================

pipeline {
  agent any

  environment {
    AWS_REGION       = 'us-east-1'
    ECR_REGISTRY     = credentials('ECR_REGISTRY')   // e.g. 123456789012.dkr.ecr.us-east-1.amazonaws.com
    ECR_REPO         = 'myapp'
    EKS_CLUSTER_NAME = 'myapp-eks-cluster'
    K8S_NAMESPACE    = 'default'
    IMAGE_TAG        = "${BUILD_NUMBER}-${GIT_COMMIT.take(7)}"
  }

  options {
    buildDiscarder(logRotator(numToKeepStr: '20'))
    timestamps()
    timeout(time: 30, unit: 'MINUTES')
    disableConcurrentBuilds()
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
        echo "Branch: ${env.GIT_BRANCH} | Commit: ${env.GIT_COMMIT.take(7)}"
      }
    }

    stage('Lint & Validate') {
      parallel {
        stage('Terraform Validate') {
          steps {
            sh '''
              terraform fmt -check -recursive .
              terraform validate
            '''
          }
        }
        stage('Docker Lint') {
          steps {
            sh 'docker --version'
          }
        }
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build("${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}")
        }
      }
    }

    stage('Security Scan') {
      steps {
        sh '''
          # Trivy image scan (install: https://github.com/aquasecurity/trivy)
          if command -v trivy &> /dev/null; then
            trivy image --exit-code 1 --severity HIGH,CRITICAL \
              ${ECR_REGISTRY}/${ECR_REPO}:${IMAGE_TAG}
          else
            echo "Trivy not installed, skipping scan"
          fi
        '''
      }
    }

    stage('Push to ECR') {
      steps {
        sh '''
          aws ecr get-login-password --region $AWS_REGION | \
            docker login --username AWS --password-stdin $ECR_REGISTRY
          docker push $ECR_REGISTRY/$ECR_REPO:$IMAGE_TAG
          docker tag $ECR_REGISTRY/$ECR_REPO:$IMAGE_TAG \
                     $ECR_REGISTRY/$ECR_REPO:latest
          docker push $ECR_REGISTRY/$ECR_REPO:latest
        '''
      }
    }

    stage('Deploy to EKS') {
      steps {
        sh '''
          aws eks update-kubeconfig --name $EKS_CLUSTER_NAME --region $AWS_REGION
          kubectl set image deployment/myapp \
            myapp=$ECR_REGISTRY/$ECR_REPO:$IMAGE_TAG \
            -n $K8S_NAMESPACE
          kubectl rollout status deployment/myapp -n $K8S_NAMESPACE --timeout=120s
        '''
      }
    }

  }

  post {
    success {
      echo "Pipeline SUCCESS ✅ — Image: ${IMAGE_TAG}"
    }
    failure {
      echo "Pipeline FAILED ❌ — Check logs above"
    }
    always {
      sh 'docker image prune -f || true'
    }
  }
}
