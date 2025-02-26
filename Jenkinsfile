pipeline {
    agent any
    environment {
        REGISTRY = "k8s-vga-worker1:5000"
        IMAGE_NAME = "group1-team6-eureka-client-cards"
        IMAGE_TAG = "v1.6"
        CONTAINER_NAME = "team6-eureka-client-cards"
        NAMESPACE = "group1-team6"
        JAVA_HOME = "/usr/local/java21"
        PATH = "${JAVA_HOME}/bin:${env.PATH}"
    }
    stages {
        stage('Checkout') {
            steps {
                sh 'java -version'
                sh 'mvn -version'
                sh "echo ${IMAGE_NAME} ${IMAGE_TAG}"
                // Git 저장소에서 소스 코드 체크아웃 (branch 지정 : 본인 repository의 branch 이름으로 설정)
                git branch: 'step4', url: 'https://github.com/jghan-no1/eureka-client-card.git'
            }
        }
        stage('Build with Maven') {
            steps {
                script {
                    sh 'mvn clean package -DskipTests'
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    sh "docker push ${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
        stage('Make Deployment and Service') {
            steps {
                script {
                    sh "kubectl apply -f yaml/start.yaml"
                }
            }
        }
        stage('Deployment Image to Update') {
            steps {
                script {
                    // Kubenetes에서 특정 Deployment의 컨테이너 이미지를 업데이트 (아래 이름은 중복되지 않게 주의하여 지정, deployment, selector 이름으로)
                    sh "kubectl set image deployment/${CONTAINER_NAME} ${CONTAINER_NAME}=${REGISTRY}/${IMAGE_NAME}:${IMAGE_TAG} --namespace=${NAMESPACE}"
                }
            }
        }
    }
}
