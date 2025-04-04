data "google_container_cluster" "my_cluster" {
  name     = "java-rest-app"
  location = var.region
  project  = var.project_id
}

data "google_client_config" "provider" {}

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
          image = "northamerica-northeast1-docker.pkg.dev/off-net-dev/lendly-demo/spring-boot-rest-app:${var.image_tag}"
        }
      }
    }
  }
}