terraform {
  backend "gcs" {
    bucket = "tf_backend_java_cicd"
    prefix = "terraform/state/infra"
  }
}