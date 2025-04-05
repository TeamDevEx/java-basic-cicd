module "deployment" {
  source = "./modules/deployment"

  environment = var.environment
  project_id  = var.project_id
  region      = var.region
  repo_name   = var.repo_name
  image_tag   = var.image_tag
}

resource "kubernetes_namespace" "env" {
  metadata {
    name = var.environment
  }
}

