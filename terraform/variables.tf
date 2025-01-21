variable "project" {
  type    = string
  default = "ee-india-se-data"
}

variable "cloud_storage" {
  type = object({
    bucket_name                 = string
    location                    = string
    storage_class               = string
    public_access_prevention    = string
    uniform_bucket_level_access = bool
    force_destroy               = bool
  })
  default = {
    bucket_name                 = "se-data-landing-amit"
    location                    = "asia-south1"
    storage_class               = "STANDARD"
    public_access_prevention    = "enforced"
    uniform_bucket_level_access = true
    force_destroy               = true
  }
}

variable "snowflake" {
  type = object({
    database                    = string
    schema                      = string
    # private_key                 = string
    # private_key_passphrase      = string
  })
}
