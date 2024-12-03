resource "google_storage_bucket" "cloud_storage_bucket" {
  name                        = var.bucket_name
  location                    = var.location
  storage_class               = var.storage_class
  public_access_prevention    = var.public_access_prevention
  uniform_bucket_level_access = var.uniform_bucket_level_access
  force_destroy               = var.force_destroy
}
