output "storage_url" {
  description = "Storage endpoint URL"
  value       = module.curator_storage.storage_url
}

output "access_key_id" {
  description = "Storage account name (Access Key ID)"
  value       = module.curator_storage.access_key_id
}

output "bucket" {
  description = "Container name"
  value       = module.curator_storage.bucket
}

output "resource_group_name" {
  description = "Name of the resource group"
  value       = module.curator_storage.resource_group_name
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = module.curator_storage.storage_account_id
}
