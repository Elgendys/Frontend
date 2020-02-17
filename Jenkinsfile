pipeline {
 agent any
      stages{
    stage('Check SCM') {
         steps {
        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'Jenkins Server', url: 'git@github.com:Elgendys/Frontend.git']]])    }
    }
    stage('Initial') {
         steps {
        sh label: '', script: 'sh -x ./initial.sh'
        }
    }
        stage('Static Analysis') {
                steps {
                   script {
        def scannerHome = tool name: 'sonar-scanner'

        withSonarQubeEnv('sonar') {
            sh "${scannerHome}/bin/sonar-scanner -Dsonar.sources=/var/lib/jenkins/workspace/$JOB_NAME/src"
        }
         }
                }
    }
 stage('Unit Test') {
        steps {
        sh 'ng test  --watch=false'
    }
}

    stage('stash file'){
        steps {
 stash name: "first-stash", includes: "**"
        }
}
stage('copyfiles'){
            steps {
            node('frontend-1') {
        unstash "first-stash"
    }
                node('frontend-2') {
        unstash "first-stash"
    }
    }
}
 stage ('build docker'){
       steps {
          node('frontend-1') {
        sh 'docker-compose build'
      }
                node('frontend-2') {
        sh 'docker-compose build'
      }
}
}
      }
 stage ('Run Containers'){
       steps {
          node('frontend-1') {
        sh 'docker-compose  up --scale frontend=3 -d'
      }
                node('frontend-2') {
        sh 'docker-compose  up --scale frontend=3 -d'
      }
}
}
      }



