resource "google_container_cluster" "my_cluster" {
  name     = "my_cluster"
  location = var.region
  enable_autopilot = true
}