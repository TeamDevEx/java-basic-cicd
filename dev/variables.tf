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
  default     = ""
  description = "Docker Image Tag"
}

variable "environment" {
  description = "Deployment environment: development, staging, or production"
  type        = string
  default     = "development"
  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment must be one of: development, staging, production."
  }
}


