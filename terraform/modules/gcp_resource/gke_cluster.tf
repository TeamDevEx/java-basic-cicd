resource "google_container_cluster" "java_springboot_devops" {
  name     = "java-springboot-devops"
  location = var.region
  enable_autopilot = true
}