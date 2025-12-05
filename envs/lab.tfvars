deployments = {
  myFirstDeployment = {
    blueprint_name    = "Simple IAC Blueprint"
    deployment_name      = "Ubuntu Provisioned by TF (x5)"
    description          = "Provisioned by TF"
    inputs = {
      flavorSize = "medium"
      diskCount  = 4
      diskSize   = 10
      image      = "ubuntu22"
    }
  }
}