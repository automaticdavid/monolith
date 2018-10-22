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
  
   stage('Publish Artifact')  {
  
      def jfrog = Artifactory.server('jfrog')
      def uploadSpec = """{
       "files": [
        {
         "pattern": "*.war",
         "target": "monolith"
        }
        ]
      }"""
     def buildInfo = Artifactory.newBuildInfo()
     buildInfo.name = 'monolith'
     buildInfo.number = 'build-' + env.BUILD_ID
     jfrog.upload spec: uploadSpec, buildInfo: buildInfo
     jfrog.publishBuildInfo buildInfo
    
     }
  
    stage('Deploy') {

        ansibleTower(
            towerServer: 'tower',
            templateType: 'job',
            jobTemplate: 'rhforum-aws-eap',
            importTowerLogs: true,
            removeColor: false,
            verbose: true,
            extraVars: '''---
scope: "*eap*"
version: "1.1.0"
jboss_eap_ha: true
     '''
        )
    }
     
 }    


    
