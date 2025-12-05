variable "project_name" {
}
variable "description" {
}

variable "blueprint_name" {

}

variable "deployment_name" {
}
variable "inputs" {
  description = "Arbitrary inputs to pass to the blueprint"
  type        = any
  default     = {}
}
