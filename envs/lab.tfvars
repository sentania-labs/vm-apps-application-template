virtual_machines = {
  sample_iac_machine = {
    virtual_machine_name        = "sample-machine1"
    virtual_machine_description = "Deployed via TF - Do not Edit"
    image                       = "ubuntu24"
    flavor                      = "medium"
    tags = [
      { key = "serviceLevel", value = "production" },
      { key = "application", value = "hr" }
    ]
    constraints = [
      {
        mandatory  = true
        expression = "application:sandbox"   #make sure to update this in the future, this is just an example
      }
    ]
    image_disk_constraints = [
      {
        mandatory  = true
        expression = "storageTier:iscsi"
      }
    ]
  }
},
deployments = {
  blueprintdeployment1 = {
    blueprint_name    = "Simple IAC Blueprint"
    deployment_name   = "Sample Deployment"
    description       = "Provisioned by TF"
    blueprint_version = "explicittags"
    inputs = {
      flavorSize   = "medium"
      diskCount    = 2
      diskSize     = 10
    }
  }
}