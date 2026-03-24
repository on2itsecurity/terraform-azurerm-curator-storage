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

variable "tags" {
  description = "Map of tags applied to all resources"
  type        = map(string)
  default     = {}
}

# Storage account
variable "storage_account_name" {
  description = "Storage account name (3-24 chars, lowercase alphanumeric only, globally unique)"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.storage_account_name))
    error_message = "Storage account name must be 3-24 characters, lowercase letters and numbers only."
  }
}

variable "account_tier" {
  description = "Storage account tier (Standard or Premium)"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Must be either 'Standard' or 'Premium'."
  }
}

variable "replication_type" {
  description = "Replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)"
  type        = string
  default     = "LRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.replication_type)
    error_message = "Must be one of: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  }
}

# Container
variable "container_name" {
  description = "Blob container name for Curator log storage"
  type        = string
  default     = "curator-logs"
}

variable "container_access_type" {
  description = "Container access level (private, blob, container)"
  type        = string
  default     = "private"

  validation {
    condition     = contains(["private", "blob", "container"], var.container_access_type)
    error_message = "Must be one of: private, blob, container."
  }
}

# Advanced
variable "enable_hierarchical_namespace" {
  description = "Enable Data Lake Gen2 hierarchical namespace"
  type        = bool
  default     = false
}

variable "allow_public_access" {
  description = "Allow public access to blobs/containers"
  type        = bool
  default     = false
}

# Network access
variable "public_network_access" {
  description = "Allow all public network access (Allow) or restrict to specific IPs (Deny)"
  type        = string
  default     = "Allow"

  validation {
    condition     = contains(["Allow", "Deny"], var.public_network_access)
    error_message = "Must be either 'Allow' or 'Deny'."
  }
}

variable "allowed_ip_ranges" {
  description = "List of IP ranges allowed to access storage (only used when public_network_access = Deny)"
  type        = list(string)
  default     = []
}

# Lifecycle
variable "enable_object_lifecycle" {
  description = "Enable lifecycle management rules for cost optimization"
  type        = bool
  default     = true
}

variable "transition_to_cool_days" {
  description = "Days before transitioning blobs to Cool tier (0 disables)"
  type        = number
  default     = 30
}

variable "transition_to_cold_days" {
  description = "Days before transitioning blobs to Cold tier (0 disables)"
  type        = number
  default     = 90
}

variable "expiration_days" {
  description = "Days before blobs are deleted (0 disables)"
  type        = number
  default     = 0
}
