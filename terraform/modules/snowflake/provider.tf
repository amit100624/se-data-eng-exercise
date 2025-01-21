terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
    }
  }
}

provider "snowflake" {
  #   organization_name      = var.organization_name
  #   account_name           = var.account_name
  #   user                   = var.user
  # authenticator          = "SNOWFLAKE_JWT"
  # private_key            = var.private_key
  # private_key_passphrase = var.private_key_passphrase
}
