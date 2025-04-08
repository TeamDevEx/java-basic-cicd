data "google_container_cluster" "my_cluster" {
  name     = "java-rest-app"
  location = var.region
  project  = var.project_id
}

data "google_client_config" "provider" {}

resource "kubernetes_horizontal_pod_autoscaler_v2" "java_rest_app_hpa" {
  metadata {
    name      = "java-rest-app-hpa-dev"
    namespace = "namespace-development"
    labels = {
      app = "java-rest-app-dev"
    }
  }

  spec {
    scale_target_ref {
      kind        = "Deployment"
      name        = "deployment"
      api_version = "apps/v1"
    }

    min_replicas = 1
    max_replicas = 3

    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type                = "Utilization"
          average_utilization = 80
        }
      }
    }
  }
}


resource "kubernetes_service" "dev_service" {
  metadata {
    name = "dev-service"
    namespace = "namespace-development"
  }

  spec {
    selector = {
      app = "java-rest-app-dev"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
