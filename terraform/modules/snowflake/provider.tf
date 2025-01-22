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

  preview_features_enabled = ["snowflake_table_resource"]
}
