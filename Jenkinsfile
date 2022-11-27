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