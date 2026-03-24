variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure region for storage resources"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Resource group name for storage resources"
  type        = string
  default     = "rg-curator-storage"
}

variable "storage_account_name" {
  description = "Storage account name (3-24 chars, lowercase alphanumeric only, globally unique)"
  type        = string
}

variable "allowed_ip_ranges" {
  description = "List of IP ranges allowed to access storage"
  type        = list(string)
  default     = ["185.46.232.0/22"]
}

variable "tags" {
  description = "Map of tags applied to all resources"
  type        = map(string)
  default = {
    ManagedBy = "Terraform"
  }
}
