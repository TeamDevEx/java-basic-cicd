# update SA
resource "google_container_cluster" "jva_cicd_cluster" {
  name     = "jva-cicd-cluster"
  location = var.region
  enable_autopilot = true
}