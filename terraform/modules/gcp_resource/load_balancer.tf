resource "google_compute_address" "service_ip" {
  name         = "my-service-ip"
  region       = "northamerica-northeast1"
  address_type = "EXTERNAL"
}

resource "kubernetes_service" "my_service" {
  metadata {
    name = "my-service"
    annotations = {
      "networking.gke.io/load-balancer-type" = "External"
    }
  }

  spec {
    selector = {
      app = "java-rest-app"  # This should match your deployment's label
    }

    port {
      port        = 80
      target_port = 8080
    }

    type                    = "LoadBalancer"
    load_balancer_ip        = google_compute_address.service_ip.address
    external_traffic_policy = "Regional"
  }
}

output "service_ip" {
  value = google_compute_address.service_ip.address
}