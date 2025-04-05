resource "kubernetes_service" "my_service" {
  metadata {
    name = "my-service"
    namespace = "namespace-staging"
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
