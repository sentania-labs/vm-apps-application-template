variable "vcfa_url" {
  type    = string
  default = "https://api.mgmt.cloud.vmware.com"
}

variable "vcfa_refresh_token" {
  type      = string
  sensitive = true
}

variable "vcfa_organization" {
  type = string
}

variable "vcfa_project" {
  type = string
}


variable "insecure" {
  type    = bool
  default = true
}
########################################
# Deployment Requests
########################################

/**
 * deployments
 *
 * A map of deployment request definitions. Each key represents a logical
 * deployment name, and the associated value defines how that deployment
 * should be created within Aria Automation (VCF-A).
 *
 * Structure:
 *
 * deployments = {
 *   key = {
 *     project_name      = string
 *     catalog_item_name = string
 *     catalog_item_version = string
 *     deployment_name   = string
 *     description       = string
 *
 *     // Freeform blueprint inputs:
 *     //   These are passed directly to the vRA deployment and must match
 *     //   the blueprint's expected input schema. The module does *not*
 *     //   enforce specific fields, allowing each blueprint to define its
 *     //   own input requirements.
 *     inputs = {
 *       <string-key> = any
 *     }
 *   }
 * }
 *
 * Notes:
 *   - `inputs` is typed as map(any) to allow arbitrary key/value pairs.
 *   - Different deployments can define completely different input maps.
 *   - The module should simply forward these inputs to vRA via inputs_json.
 */
variable "deployments" {
  description = "Map of vRA deployment request definitions."
  type        = any
}

