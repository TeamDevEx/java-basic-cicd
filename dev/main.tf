module "gcp_resource" {
  source     = "./modules/gcp_resource"
  project_id = var.project_id
  region     = var.region
  repo_name  = var.repo_name
  image_tag  = var.image_tag
  environment = var.environment
}
