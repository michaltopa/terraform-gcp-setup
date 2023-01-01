# GCP bootstrap overview
Prepare GCP cloud to store tf-state even more safely + sops for encrypt/decrypt variables for further store in repository.

# Setup for GCP 
```bash
gcloud config set project PROJECT_ID
gcloud auth application-default login
```

## Input
- gcp_region
- default_region

## Input (optional)
- kms_region
- gcs_region

## Output
- bucket name
- sops_kms_key_address

## Usage
1. Clone repository
2. Set variables
3. Use proper credentials
```bash
gcloud auth application-default login
```
4. Execute:
- `terraform workspace [new|select] [dev|staging|production]`
- `terraform init`
- `terraform plan`
- `terraform apply`