data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${google_container_cluster.default.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(google_container_cluster.default.master_auth[0].cluster_ca_certificate)

  ignore_annotations = [
    "^autopilot\\.gke\\.io\\/.*",
    "^cloud\\.google\\.com\\/.*"
  ]
}

resource "kubernetes_deployment" "deployment_1" {
  metadata {
    name      = "deployment-1"
    namespace = "default"
    labels = {
      app = "deployment-1"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "deployment-1"
      }
    }

    template {
      metadata {
        labels = {
          app = "deployment-1"
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

resource "kubernetes_horizontal_pod_autoscaler_v2" "deployment_1_hpa" {
  metadata {
    name      = "deployment-1-hpa-iwwt"
    namespace = "default"
    labels = {
      app = "deployment-1"
    }
  }

  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name        = "deployment-1"
    }

    min_replicas = 1
    max_replicas = 5

    metric {
      type = "Resource"

      resource {
        name = "cpu"
        target {
          type               = "Utilization"
          average_utilization = 80
        }
      }
    }
  }
}
