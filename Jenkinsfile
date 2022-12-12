pipeline {
	agent none
        stages {
           stage ("tomcat buid & move to other node") {
	       agent {label "slaveone"}
               steps {
                      sh 'sudo mvn package'
		      sh 'ls'
		      sh 'scp -R target/hello-world-war-1.0.0.war root@172.31.2.183:/opt/tomcat/webapps'
		      echo "sucessfully copied build to other node"
	       }
	   }
	   stage ('deploy in node2') {
	   	agent {label "slavetwo"}
		steps {
		    sh 'sh /opt/tomcat/bin/shutdown.sh'                   
                    sh 'sleep 3'
                    sh 'sh /opt/tomcat/bin/startup.sh'
                    echo "deployment is sucessfull"
                    echo "copy the public ip of instace and open it in browser with port:8090"
		}
	   } 	   
        }
}
