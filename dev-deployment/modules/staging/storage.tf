resource "google_storage_bucket" "staging_demo_javac" {
  name          = "staging_demo_javac"
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