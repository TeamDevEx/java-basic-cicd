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
    name      = "java-rest-app"
    namespace = kubernetes_namespace.env.metadata[0].name
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
          image = "northamerica-northeast1-docker.pkg.dev/${var.project_id}/${var.repo_name}/spring-boot-rest-app:${var.image_tag}"
        }
      }
    }
  }
}


resource "kubernetes_horizontal_pod_autoscaler_v2" "java_rest_app_hpa" {
  metadata {
    name      = "java-rest-app-hpa-kfqf"
    namespace = kubernetes_namespace.env.metadata[0].name
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


resource "kubernetes_service" "my_service" {
  metadata {
    name = "my-service"
    namespace = kubernetes_namespace.env.metadata[0].name
  }

  spec {
    selector = {
      app = "java-rest-app"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

