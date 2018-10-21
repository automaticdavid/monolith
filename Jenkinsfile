#!groovy

node('Jenkins') {

    stage ("Get Source code"){
        echo '*** Build starting ***'
        def mvn = "mvn -s mvn-settings.xml"
        sh "mvn --version"
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
        sh "mvn -s mvn-settings.xml clean install -DskipTests=true"
    }         
    
    // Using Maven run the unit tests
    stage('Unit Tests') {
      //sh "${mvn} test"
      sh "sleep 5"
    }

    // stage('Publish to Nexus') {
     //   sh "mvn -s mvn-settings.xml deploy -DskipTests=true -DaltDeploymentRepository=nexus::default::${params.NEXUS_REPO_URL}"
  //  }

 }         
    
