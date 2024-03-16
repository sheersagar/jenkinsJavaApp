pipeline {
    agent any

    tools {
        jdk 'jdk17'
        maven 'maven3'
    }


    stages {
        stage("Clean Workspace") {
            steps {
                cleanWs()
            }
        }


        stage("Checkout from SCM") {
            steps {
                git branch: 'main', changelog: false, credentialsId: 'git-hub-cred', poll: false, url: 'https://github.com/sheersagar/jenkinsJavaApp.git'
            }
        } 

        stage("Build Application") {
            steps {
                sh 'mvn clean package'
            }
        }

        stage("Test Application") {
            steps {
                sh 'mvn test'
            }
        }

        stage("Sonar Qube Analysis") {
            steps {
                  script {
                    withSonarQubeEnv(credentialsId: 'sonar-scanner') {
                    sh 'mvn sonar:sonar'
                  }
                }
            }
        }

        stage("Build and Push Docker Image") {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker-cred') {
                        docker.build("vishv3432/my_first_java_app:${BUILD_NUMBER}", ".")
                        
                        def dockerImage = docker.image('vishv3432/my_first_java_app:${BUILD_NUMBER}')
                        dockerImage.push()

                    }
                }
            }
        }
    }   
}