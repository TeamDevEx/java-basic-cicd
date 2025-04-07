data "google_container_cluster" "my_cluster" {
  name     = "java-rest-app"
  location = var.region
  project  = var.project_id
}

data "google_client_config" "provider" {}

