# Complete Curator Storage Deployment

Deploys Azure Storage for Curator with network restrictions, lifecycle policies, and log expiration.

## Usage

```bash
# Copy and fill in the variables
cp terraform.tfvars.example terraform.tfvars

# Deploy (using Terraform or OpenTofu)
tofu init    # or: terraform init
tofu apply
```
