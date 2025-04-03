variable "project_id" {
  type        = string
  default     = "off-net-dev"
  description = "project to deploy java spring boot demo resources to"
}

variable "region" {
  type        = string
  default     = "northamerica-northeast1"
  description = "Region to deploy java spring boot demo resources in."
}

variable "repo_name" {
  type        = string
  default     = "lendly-demo"
  description = "Artifact Registry Repository Name"
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "Docker Image Tag"
}




