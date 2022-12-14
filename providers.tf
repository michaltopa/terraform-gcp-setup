# Configuration used by defined providers
provider "google" {
  project = var.gcp_project
  region  = var.default_region
}
