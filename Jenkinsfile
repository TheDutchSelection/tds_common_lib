#!groovy

utils = new tds.jenkins.Utilities()
exitCode = 0

dependentImageName = 'thedutchselection/app_env_tds_common_lib'
dependentImageTag = 'latest'
mainImageName = 'thedutchselection/tds_common_lib'
label = 'test_tds_common_lib_' + env.BRANCH_NAME

def runTests() {
  def postgresqlContainer = utils.runPostgresql(label)
  def redisContainer = utils.runRedis(label)
  def rspecOpts = tdsJenkinsGlobals.getStandardRspecOpts()

  def testResult = runMainContainer(mainDockerImage, postgresqlContainer, redisContainer, rspecOpts)

  return testResult
}

def runMainContainer(mainDockerImage, postgresqlContainer, redisContainer, rspecOpts) {
  def dockerArgs =
    '-l "' + label + '" ' +
    '-e "DATABASE_HOST=' + utils.dockerContainerIp(postgresqlContainer) + '" ' +
    '-e "DATABASE_PORT=' + utils.dockerContainerPort(postgresqlContainer, '5432/tcp') + '" ' +
    '-e "DATABASE_PASSWORD=' + tdsJenkinsGlobals.postgresqlTestPassword + '" ' +
    '-e "DATABASE_USER=' + tdsJenkinsGlobals.postgresqlTestUsername + '" ' +
    '-e "REDIS_HOST=' + utils.dockerContainerIp(redisContainer) + '" ' +
    '-e "REDIS_PORT=' + utils.dockerContainerPort(redisContainer, '6379/tcp') + '" ' +
    '-e "RAILS_ENV=test" ' +
    '-e "RUN_TYPE=test" ' +
    '-e "RSPEC_OPTS=' + rspecOpts + '" ' +
    mainDockerImage.imageName()

  def result = sh(script: "docker run " + dockerArgs, returnStatus: true)

  return result
}

try {
  stage('Setup') {
    node {
      utils.standardPipelineSetup(dependentImageName, dependentImageTag)
      checkout scm
    }
  }

  stage('Build') {
    node {
      mainDockerImage = utils.buildDockerImage(env.TDS_REGISTRY_ADDRESS, mainImageName, env.BRANCH_NAME)
    }
  }

  stage('Test') {
    node {
      def testResult = runTests()

      if (testResult != 0) {
        throw new Exception('Tests failed!')
      }
    }
  }
}

catch (err) {
  exitCode = 1
}

finally {
  stage('Cleanup') {
    node {
      utils.cleanupDockerContainers(label)
      utils.cleanupDockerImage(env.TDS_REGISTRY_ADDRESS, mainImageName, env.BRANCH_NAME)
    }
  }

  stage('Finalize') {
    node {
      if (exitCode == 1) {
        sh 'exit 1'
      }
    }
  }
}
