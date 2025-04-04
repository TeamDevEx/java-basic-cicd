resource "google_storage_bucket" "environment_rero" {
  name          = "environment_rero"
  location      = var.region
  force_destroy = true
  project       = var.project_id

  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}