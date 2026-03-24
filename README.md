# AUXO Curator -- Azure Storage Module

Terraform/OpenTofu module for deploying Azure Blob Storage for AUXO Curator log ingestion. This module creates a storage account with a blob container and configurable lifecycle policies for cost optimization.

## Prerequisites

- Azure subscription
- Terraform >= 1.6.0 or OpenTofu >= 1.6.0

## Usage

```hcl
module "curator_storage" {
  source  = "on2itsecurity/curator-storage/azurerm"
  version = "~> 1.0"

  storage_account_name = "mycompanycuratorlogs"
  resource_group_name  = "rg-curator-storage"

  tags = {
    Environment = "production"
  }
}
```

## Requirements

| Name                 | Version  |
| -------------------- | -------- |
| terraform / opentofu | >= 1.6.0 |
| azurerm              | >= 4.0.0 |

## Inputs

| Name                          | Description                                                                | Type           | Default                | Required |
| ----------------------------- | -------------------------------------------------------------------------- | -------------- | ---------------------- | -------- |
| location                      | Azure region for storage resources                                         | `string`       | `"westeurope"`         | no       |
| resource_group_name           | Resource group name for storage resources                                  | `string`       | `"rg-curator-storage"` | no       |
| tags                          | Map of tags applied to all resources                                       | `map(string)`  | `{}`                   | no       |
| storage_account_name          | Storage account name (3-24 chars, lowercase alphanumeric, globally unique) | `string`       | n/a                    | **yes**  |
| account_tier                  | Storage account tier (Standard or Premium)                                 | `string`       | `"Standard"`           | no       |
| replication_type              | Replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)                      | `string`       | `"LRS"`                | no       |
| container_name                | Blob container name for Curator log storage                                | `string`       | `"curator-logs"`       | no       |
| container_access_type         | Container access level (private, blob, container)                          | `string`       | `"private"`            | no       |
| enable_hierarchical_namespace | Enable Data Lake Gen2 hierarchical namespace                               | `bool`         | `false`                | no       |
| allow_public_access           | Allow public access to blobs/containers                                    | `bool`         | `false`                | no       |
| public_network_access         | Allow all public network access or restrict to specific IPs                | `string`       | `"Allow"`              | no       |
| allowed_ip_ranges             | List of IP ranges allowed when public_network_access = Deny                | `list(string)` | `["185.46.232.0/22"]`  | no       |
| enable_object_lifecycle       | Enable lifecycle management rules                                          | `bool`         | `true`                 | no       |
| transition_to_cool_days       | Days before transitioning to Cool tier (0 disables)                        | `number`       | `30`                   | no       |
| transition_to_cold_days       | Days before transitioning to Cold tier (0 disables)                        | `number`       | `90`                   | no       |
| expiration_days               | Days before blobs are deleted (0 disables)                                 | `number`       | `0`                    | no       |

## Outputs

| Name                | Description                                                |
| ------------------- | ---------------------------------------------------------- |
| storage_url         | Storage endpoint URL (without protocol and trailing slash) |
| access_key_id       | Storage account name (used as Access Key ID)               |
| secret_access_key   | Primary access key (sensitive)                             |
| bucket              | Container name (bucket equivalent)                         |
| connection_string   | Primary connection string (sensitive)                      |
| resource_group_name | Name of the resource group                                 |
| resource_group_id   | ID of the resource group                                   |
| storage_account_id  | ID of the storage account                                  |

## Lifecycle Management

By default, the module enables cost-optimization lifecycle rules:

| Tier   | After Days   | Cost Impact                     |
| ------ | ------------ | ------------------------------- |
| Cool   | 30           | ~50% cheaper storage            |
| Cold   | 90           | ~70% cheaper storage            |
| Delete | disabled (0) | Set `expiration_days` to enable |

## Examples

- [Basic](./examples/basic) -- Minimal deployment with required variables only
- [Complete](./examples/complete) -- Full deployment with lifecycle and network restrictions

## License

MIT
