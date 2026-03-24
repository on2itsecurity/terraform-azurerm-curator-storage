# Basic Curator Storage Deployment

Deploys an Azure Storage Account with default settings for Curator log ingestion.

## Usage

```bash
# Using Terraform or OpenTofu
tofu init    # or: terraform init
tofu apply -var="subscription_id=YOUR_SUB_ID" \
           -var="storage_account_name=mycompanycuratorlogs"
```
