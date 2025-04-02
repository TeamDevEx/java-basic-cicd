resource "kubernetes_service" "java_rest_app_service" {
  metadata {
    name      = "java-rest-app-service"
    namespace = "default"
  }
  spec {
    selector = {
      app = kubernetes_deployment.deployment.metadata[0].labels.app
    }
    port {
      port        = 8080
      target_port = 8080
    }
    type = "NodePort"
  }
}

resource "kubernetes_ingress_v1" "java_rest_app_ingress" {
  metadata {
    name = "java-rest-app-ingress"
    annotations = {
      "kubernetes.io/ingress.class"                 = "gce"
      "kubernetes.io/ingress.global-static-ip-name" = google_compute_global_address.java_rest_app_ip.name
    }
  }

  spec {
    default_backend {
      service {
        name = kubernetes_service.java_rest_app_service.metadata[0].name
        port {
          number = 8080
        }
      }
    }
  }
}

resource "google_compute_global_address" "java_rest_app_ip" {
  name = "java-rest-app-ip"
}

output "java_rest_app_ip" {
  value = google_compute_global_address.java_rest_app_ip.address
}