variable "project" {
  type = string
}

variable "cloud_storage" {
  type = object({
    bucket_name                 = string
    staging_bucket_name         = string
    location                    = string
    storage_class               = string
    public_access_prevention    = string
    uniform_bucket_level_access = bool
    force_destroy               = bool
  })
}

variable "snowflake" {
  type = object({
    organization  = string
    account       = string
    user          = string
    authenticator = string
    database      = string
    schema        = string
  })
}
