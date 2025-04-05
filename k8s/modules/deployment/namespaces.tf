resource "kubernetes_namespace" "dev" {
  metadata {
    name = "development"
  }
}

resource "kubernetes_namespace" "staging" {
  metadata {
    name = "staging"
  }
}
