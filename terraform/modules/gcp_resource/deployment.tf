data "google_container_cluster" "my_cluster" {
  name     = "java-rest-app"
  location = var.region
  project  = var.project_id
}

data "google_client_config" "provider" {}

# deploy version 2 4-3-2025
resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = "java-rest-app"
    namespace = "default"
    labels = {
      app = "java-rest-app"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "java-rest-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "java-rest-app"
        }
      }

      spec {
        container {
          name  = "spring-boot-rest-app-1"
          image = "northamerica-northeast1-docker.pkg.dev/off-net-dev/lendly-demo/spring-boot-rest-app:latest"
        }
      }
    }
  }
}

resource "kubernetes_horizontal_pod_autoscaler_v2" "java_rest_app_hpa" {
  metadata {
    name      = "java-rest-app-hpa-kfqf"
    namespace = "default"
    labels = {
      app = "java-rest-app"
    }
  }

  spec {
    scale_target_ref {
      kind        = "Deployment"
      name        = kubernetes_deployment.deployment.metadata[0].name
      api_version = "apps/v1"
    }

    min_replicas = 1
    max_replicas = 5

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