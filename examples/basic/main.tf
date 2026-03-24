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
  features {}
  subscription_id = var.subscription_id
}

module "curator_storage" {
  source  = "on2itsecurity/curator-storage/azurerm"
  version = "~> 1.0"

  storage_account_name = var.storage_account_name
}
