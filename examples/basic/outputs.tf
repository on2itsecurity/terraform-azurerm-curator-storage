output "storage_url" {
  description = "Storage endpoint URL"
  value       = module.curator_storage.storage_url
}

output "bucket" {
  description = "Container name"
  value       = module.curator_storage.bucket
}
