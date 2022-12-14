output "bucket" {
  value       = google_storage_bucket.tf_state_bucket.name
  description = "Terraform backend storage"
}

output "sops_crypto_key" {
  value = google_kms_crypto_key.sops.id
}
