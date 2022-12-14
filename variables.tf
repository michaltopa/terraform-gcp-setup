variable "gcp_project" {
  type        = string
  description = "The GCP project ID"
  default     = ""
}

variable "default_region" {
  type        = string
  description = "Default region"
  default     = "" // [us-central1, eu-central2]
}

variable "gcs_region" {
  type        = string
  description = "The GCP storage region"
  default     = "" // [us-central1, eu-central2]
}

variable "kms_region" {
  type        = string
  description = "The GCP KMS region for deployment"
  default     = "" // global or [us|eu] or [us-central1|europe-central2]
}

variable "workspaces" {
  type = map(string)
  default = {
    dev        = "dev"
    staging    = "stg"
    production = "prod"
  }
}
