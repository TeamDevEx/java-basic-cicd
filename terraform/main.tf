module "gcp_resource" {
  source     = "./modules/gcp_resource"
  project_id = var.project_id
  region     = var.region
}

