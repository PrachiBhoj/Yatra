pipeline {

    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }

    agent any

    tools {
        maven 'maven'
    }

    stages {
        stage('Checking JAVA, Maven,git') {
            steps {
                echo 'Code Compilation is In Progress!'
                sh 'mvn --version'
                sh 'java --version'
                sh 'git --version'
                sh 'whoami'
                echo "this pipeline is running via Jenkins User"
            }
        }
        stage('Code Compilation') {
            steps {
                echo 'Code Compilation is In Progress!'
                sh 'mvn --version'
                sh 'mvn clean compile'
            }
        }

        stage('Code QA Execution') {
            steps {
                echo 'Junit Test case check in Progress!'
                sh 'mvn --version'
                sh 'mvn clean test'
            }
        }

        stage('Code Package') {
            steps {
                echo 'Creating War Artifact'
                sh 'java -version'
                sh 'mvn clean package'
            }
        }

        stage('Building & Tagging Docker Image') {
            steps {
                echo 'Starting Building Docker Image'
                sh 'docker build -t satyam88/cowinapp .'
                sh 'docker build -t cowinapp .'
                echo 'Completed  Building Docker Image'
            }
        }


        stage(' Docker push to Docker Hub') {
           steps {
              script {
                 withCredentials([string(credentialsId: 'dockerhubC', variable: 'dockerhubC')]){
                 sh 'docker login docker.io -u satyam88 -p ${dockerhubC}'
                 echo "Push Docker Image to DockerHub : In Progress"
                 sh 'docker push satyam88/cowinapp:latest'
                 echo "Push Docker Image to DockerHub : In Progress"
                 }
              }
            }
        }


        stage(' Docker Image Push to Amazon ECR') {
           steps {
              script {
                 withDockerRegistry([credentialsId:'ecr:ap-south-1:ecr-credentials', url:"https://315080898736.dkr.ecr.ap-south-1.amazonaws.com"]){
                 sh """
                 echo "List the docker images present in local"
                 docker images
                 echo "Tagging the Docker Image: In Progress"
                 docker tag cowinapp:latest 315080898736.dkr.ecr.ap-south-1.amazonaws.com/cowinapp:latest
                 echo "Tagging the Docker Image: Completed"
                 echo "Push Docker Image to ECR : In Progress"
                 docker push 315080898736.dkr.ecr.ap-south-1.amazonaws.com/cowinapp:latest
                 echo "Push Docker Image to ECR : Completed"
                 """
                 }
              }
           }
        }

         /**
        stage('Upload the docker Image to Nexus') {
           steps {
              script {
                 withCredentials([usernamePassword(credentialsId: 'nexuscred', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]){
                 sh 'docker login http://13.233.166.175:8081/repository/letmefly-docker/ -u admin -p ${PASSWORD}'
                 echo "Push Docker Image to Nexus : In Progress"
                 sh 'docker push http://172.31.46.38:8081/repository/linuxacademy:latest'
                 echo "Push Docker Image to Nexus : Completed"
                 }
              }
            }
        } **/

        stage('Deploy App to K8s Cluster') {
            steps {
                sh 'whoami'
                sh 'kubectl apply -f Kubernetes/prod'
            }

        }/**
        stage('Deploy App to K8s Cluster') {
          withKubeConfig([credentialsId: 'kuberneteskubeconfig', serverUrl: 'https://api.myprodcluster.in']) {
                sh 'kubectl apply -f kubernetes/prod'
            }
        }**/
    }
}

