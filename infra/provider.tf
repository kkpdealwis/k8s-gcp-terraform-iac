#GCP Provider
provider "google" {
    access_token = var.access_token
    project = var.gcp_project
    region = var.gcp_region
}