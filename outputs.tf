output "storage_url" {
  description = "Storage endpoint URL (without https:// prefix and trailing slash)"
  value       = trimsuffix(trimprefix(azurerm_storage_account.this.primary_blob_endpoint, "https://"), "/")
}

output "access_key_id" {
  description = "Storage account name (used as Access Key ID)"
  value       = azurerm_storage_account.this.name
}

output "secret_access_key" {
  description = "Primary access key"
  value       = azurerm_storage_account.this.primary_access_key
  sensitive   = true
}

output "bucket" {
  description = "Container name (bucket equivalent)"
  value       = azurerm_storage_container.this.name
}

output "connection_string" {
  description = "Primary connection string for clients such as DuckDB"
  value       = azurerm_storage_account.this.primary_connection_string
  sensitive   = true
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.this.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.this.id
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.this.id
}
