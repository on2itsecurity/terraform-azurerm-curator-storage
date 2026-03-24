# Resource Group
resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Storage Account
resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
  account_kind             = "StorageV2"

  is_hns_enabled = var.enable_hierarchical_namespace

  allow_nested_items_to_be_public = var.allow_public_access
  min_tls_version                 = "TLS1_2"
  public_network_access_enabled   = true

  dynamic "network_rules" {
    for_each = var.public_network_access == "Deny" ? [1] : []
    content {
      default_action = "Deny"
      ip_rules       = var.allowed_ip_ranges
      bypass         = ["AzureServices"]
    }
  }

  blob_properties {
    versioning_enabled = false
  }

  tags = var.tags
}

# Blob Container
resource "azurerm_storage_container" "this" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = var.container_access_type
}

# Lifecycle Management Policy
resource "azurerm_storage_management_policy" "this" {
  count = var.enable_object_lifecycle && anytrue([
    var.transition_to_cool_days > 0,
    var.transition_to_cold_days > 0,
    var.expiration_days > 0,
  ]) ? 1 : 0
  storage_account_id = azurerm_storage_account.this.id

  rule {
    name    = "curator-lifecycle"
    enabled = true

    filters {
      blob_types = ["blockBlob"]
    }

    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than = var.transition_to_cool_days > 0 ? var.transition_to_cool_days : null
        tier_to_cold_after_days_since_modification_greater_than = var.transition_to_cold_days > 0 ? var.transition_to_cold_days : null
        delete_after_days_since_modification_greater_than       = var.expiration_days > 0 ? var.expiration_days : null
      }
    }
  }
}
