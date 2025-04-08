data "google_container_cluster" "my_cluster" {
  name     = "java-rest-app"
  location = var.region
  project  = var.project_id
}

data "google_client_config" "provider" {}

resource "kubernetes_namespace" "env" {
  metadata {
    name = "namespace-${var.environment}"  
  }
}

resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = "java-rest-app-dev"
    namespace = kubernetes_namespace.env.metadata[0].name
  }

  spec {
    replicas = 3  

    selector {
      match_labels = {
        app = "java-rest-app-dev"
      }
    }

    template {
      metadata {
        labels = {
          app = "java-rest-app-dev"
        }
      }

      spec {
        container {
          name  = "spring-boot-rest-app"
          image = "northamerica-northeast1-docker.pkg.dev/${var.project_id}/${var.repo_name}/spring-boot-rest-app:${var.image_tag}"

          resources {
            requests = {
              cpu    = "500m"
              memory = "256Mi"
            }
            limits = {
              cpu    = "1"
              memory = "512Mi"
            }
          }

          readiness_probe {
            http_get {
              path = "/healthz"
              port = 8080
            }
            initial_delay_seconds = 10
            period_seconds        = 5
          }

          liveness_probe {
            http_get {
              path = "/healthz"
              port = 8080
            }
            initial_delay_seconds = 30
            period_seconds        = 10
          }
        }
      }
    }

    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_surge       = "25%"
        max_unavailable = "0" # Ensures zero downtime during updates.
      }
    }
  }
}
