resource "google_project_service" "kms_api" {
  project            = var.gcp_project
  service            = "cloudkms.googleapis.com"
  disable_on_destroy = false
}
