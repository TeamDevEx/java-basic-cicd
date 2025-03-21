resource "google_container_cluster" "jva_cicd_cluster" {
  name     = "jva_cicd_cluster"
  location = var.region
  enable_autopilot = true
}