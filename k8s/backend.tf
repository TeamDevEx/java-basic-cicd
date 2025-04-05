terraform {
  backend "gcs" {
    bucket = "unit_economics"
    prefix = "terraform/state"
  }
}