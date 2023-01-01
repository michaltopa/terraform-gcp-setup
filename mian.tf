# Create KMS resources for sops
resource "google_kms_key_ring" "sops" {
  project  = var.gcp_project
  name     = "sops-${var.gcp_project}"
  location = var.kms_region

  depends_on = [
    google_project_service.kms_api
  ]
}

resource "google_kms_crypto_key" "sops" {
  name            = "sops-${var.gcp_project}"
  key_ring        = google_kms_key_ring.sops.id
  rotation_period = "86400s"

  lifecycle {
    prevent_destroy = true
  }

  depends_on = [
    google_project_service.kms_api
  ]
}

# Create KMS encrypted bucket and binding
data "google_storage_project_service_account" "gcs_account" {}

resource "google_kms_crypto_key_iam_binding" "binding" {
  crypto_key_id = google_kms_crypto_key.sops.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"

  members = [
    "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
  ]
}

resource "google_storage_bucket" "tf_state_bucket" {
  name     = "${var.gcp_project}-${var.workspaces[terraform.workspace]}-tf-remote-state"
  location = var.gcp_region

  public_access_prevention    = "enforced"
  uniform_bucket_level_access = true
  force_destroy               = true

  versioning {
    enabled = true
  }

  encryption {
    default_kms_key_name = google_kms_crypto_key.sops.id
  }

  lifecycle {
    prevent_destroy = true
  }

  depends_on = [
    google_kms_crypto_key_iam_binding.binding
  ]
}
