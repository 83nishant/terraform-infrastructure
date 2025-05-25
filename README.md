# Terraform Infrastructure

This repository contains Infrastructure as Code (IaC) using Terraform to manage AWS resources across different environments.

## Project Structure

```
terraform-infrastructure/
├── devops/              # DevOps infrastructure components
│   ├── vpc.tf          # VPC configuration
│   ├── ec2.tf          # EC2 instance configuration
│   ├── outputs.tf      # Output definitions
│   └── provider.tf     # AWS provider configuration
├── eks-cluster/        # Kubernetes cluster setup
├── modules/           # Reusable Terraform modules
└── remote-infra/      # Remote infrastructure components
```

## Components

### DevOps Environment
- **VPC Setup**: Using AWS VPC module (v5.x) to create network infrastructure
- **EC2 Instances**: Configured with Nginx installation
- **Security**: Implements security groups and network ACLs
- **Outputs**: Exposes important resource information

### EKS Cluster
Contains Kubernetes cluster configuration for AWS EKS

### Modules
Reusable Terraform modules for infrastructure components

### Remote Infrastructure
Additional infrastructure components for remote resources

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured
- AWS account with appropriate permissions

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Plan the changes:
```bash
terraform plan
```

3. Apply the infrastructure:
```bash
terraform apply
```

4. To destroy the infrastructure:
```bash
terraform destroy
```

## State Management

- Using local state files (not recommended for production)
- State files are ignored in git (.tfstate, .tfstate.*)
- Lock files are handled automatically

## Security Notes

- Terraform state files contain sensitive information and are excluded from git
- Variable files (.tfvars) are excluded from git
- Provider credentials should be managed securely

## Contributing

1. Follow standard Terraform formatting
2. Update documentation when making changes
3. Test changes before submitting PRs

## File Exclusions

The following files are excluded from version control:
- `.terraform/` directories
- `.terraform.lock.hcl` files
- Terraform state files (*.tfstate)
- Terraform variable files (*.tfvars)
- Override files (override.tf)
- Crash logs
