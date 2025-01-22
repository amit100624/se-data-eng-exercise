variable "project" {
  type    = string
  default = "ee-india-se-data"
}

variable "cloud_storage" {
  type = object({
    bucket_name                 = optional(string, "se-data-landing-amit")
    location                    = optional(string, "asia-south1")
    storage_class               = optional(string, "STANDARD")
    public_access_prevention    = optional(string, "enforced")
    uniform_bucket_level_access = optional(bool, true)
    force_destroy               = optional(bool, true)
  })
  default = {}
}

variable "snowflake" {
  type = object({
    database = string
    schema   = string
  })
}
