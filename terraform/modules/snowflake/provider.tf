terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
    }
  }
}

provider "snowflake" {
  organization_name = var.organization
  account_name      = var.account
  user              = var.user
  authenticator     = var.authenticator

  preview_features_enabled = [
    "snowflake_table_resource",
    "snowflake_stage_resource",
    "snowflake_file_format_resource"
  ]
}
