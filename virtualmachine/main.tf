data "vra_project" "this" {
  name = var.project_name
}
data "vra_blueprint" "this" {
  name = var.blueprint_name
}
resource "vra_deployment" "this" {
  name        = var.deployment_name
  description = var.description

  blueprint_id         = data.vra_blueprint.this.id
  project_id           = data.vra_project.this.id


  timeouts {
    create = "60m"
    delete = "2h"
  }

  inputs = {
    for key, value in var.inputs : key =>
    (can(tostring(value)) && value == tostring(value))
    ? tostring(value)
    : jsonencode(value)
  }


}



