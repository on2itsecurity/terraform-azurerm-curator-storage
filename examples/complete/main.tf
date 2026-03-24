terraform {
  required_version = ">= 1.6.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = var.subscription_id
}

module "curator_storage" {
  source  = "on2itsecurity/curator-storage/azurerm"
  version = "~> 1.0"

  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_name = var.storage_account_name

  # Network restrictions
  public_network_access = "Deny"
  allowed_ip_ranges     = var.allowed_ip_ranges

  # Lifecycle management
  enable_object_lifecycle = true
  transition_to_cool_days = 30
  transition_to_cold_days = 90
  expiration_days         = 365

  tags = var.tags
}
