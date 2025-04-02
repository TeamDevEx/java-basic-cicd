resource "google_container_cluster" "my_cluster" {
  name     = "java-rest-app"
  location = var.region
  enable_autopilot = true
}