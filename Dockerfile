pipeline {
  agent {label 'dockerbuildnode'}
  stages {
    stage ('my build') {
      steps {
        sh "echo ${BUILD_VERSION}"
        sh "docker build -t mytomcat ."
      }
    }
    stage ('publish stage') {
      steps {
        sh "echo ${BUILD_VERSION}"
        sh 'docker login -u navyakonappalli -p NaMaN@5160'
        sh 'docker tag mytomcat navyakonappalli/tomcat:${BUILD_VERSION}'
        sh 'docker push navyakonappalli/tomcat:${BUILD_VERSION}'
      }
    }
    stage ('my deploy') {
      agent {label 'dockerdeploynode'}
      steps {
        sh 'docker pull navyakonappalli/tomcat:${BUILD_VERSION}'
        sh 'docker rm -f mytomcat'
        sh 'docker run -d -p 8888:8080 --name mscontainer navyakonappalli/tomcat:${BUILD_VERSION}'
      }
    } 
  }
}
