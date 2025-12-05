output "deployment_info" {
  value = {
    id   = vra_deployment.this.id
    name = vra_deployment.this.name
  }
}