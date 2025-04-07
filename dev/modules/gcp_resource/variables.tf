variable "project_id" {
  type        = string
  description = "project to deploy resources to"
}

variable "region" {
  type        = string
  description = "Region to deploy resources in."
}

variable "repo_name" {
  description = "Artifact Registry Repository Name"
  type        = string
}

variable "image_tag" {
  description = "Docker Image Tag"
  type        = string
}

variable "environment" {
  description = "Deployment environment (e.g., development, staging, production)"
  type        = string
}