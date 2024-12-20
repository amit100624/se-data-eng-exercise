terraform {
  backend "gcs" {
    bucket = "tf-state-se-data-amit"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.12.0"
    }
  }
}

provider "google" {
  project = var.project
}

module "cloud_storage" {
  source                      = "./modules/cloud_storage"
  bucket_name                 = var.cloud_storage.bucket_name
  location                    = var.cloud_storage.location
  storage_class               = var.cloud_storage.storage_class
  public_access_prevention    = var.cloud_storage.public_access_prevention
  uniform_bucket_level_access = var.cloud_storage.uniform_bucket_level_access
  force_destroy               = var.cloud_storage.force_destroy
}
