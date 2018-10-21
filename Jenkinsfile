#!groovy

 node('maven') { 

    def mvn_version = 'maven'

    stage ("Get Source code"){
        echo '*** Build starting ***'
        // def mvn = "mvn -s mvn-settings.xml"
       withEnv( ["PATH+MAVEN=${tool mvn_version}/bin"] ) {
        sh "mvn --version"
       }   
        git url : 'https://github.com/automaticdavid/monolith/' 
    }

    def pom            = readMavenPom file: 'pom.xml'
    def packageName    = pom.name
    def version        = pom.version
    def newVersion     = "${version}-${BUILD_NUMBER}"
    def artifactId     = pom.artifactId
    def groupId        = pom.groupId

    // Using Mav build the war file
    stage('Build war file') {
      withEnv( ["PATH+MAVEN=${tool mvn_version}/bin"] ) {
        sh "mvn clean install -DskipTests=true"
        }         
    }         
    
    // Using Maven run the unit tests
    stage('Unit Tests') {
      //sh "${mvn} test"
      sh "sleep 5"
    }
  
   stage('Artifact Mgmt')  {
  
      def arti = Artifactory.server('jfrog')
      def uploadSpec = """{
       "files": [
        {
         "pattern": "monolith/*.war",
         "target": "monolith"
        }
        ]
      }"""
     server.upload(uploadSpec)
    
    
     }
    
    // stage('Publish to Nexus') {
     //   sh "mvn -s mvn-settings.xml deploy -DskipTests=true -DaltDeploymentRepository=nexus::default::${params.NEXUS_REPO_URL}"
  //  }
     
 }    


    
