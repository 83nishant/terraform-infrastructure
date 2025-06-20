# Remote Infrastructure

This directory contains Terraform configurations for managing remote state infrastructure components in AWS.

## Components

### DynamoDB Table
- **Purpose**: State locking mechanism for Terraform
- **Table Name**: `my-state-table`
- **Configuration**:
  - Billing Mode: PAY_PER_REQUEST
  - Hash Key: LockID
  - Attributes: LockID (String)

## Usage

1. Initialize the Terraform working directory:
```bash
terraform init
```

2. Review the planned changes:
```bash
terraform plan
```

3. Apply the infrastructure:
```bash
terraform apply
```

## State Management
This configuration creates the necessary infrastructure for managing Terraform state remotely:
- DynamoDB table for state locking
- Prevents concurrent modifications to the infrastructure

## Prerequisites
- AWS credentials configured
- Terraform >= 1.0
- Appropriate AWS permissions to create DynamoDB tables

## Important Notes
- The DynamoDB table is crucial for state management
- Deleting this infrastructure could impact other Terraform configurations
- Ensure proper access controls are in place

## Configuration Details

### DynamoDB Table Properties
```hcl
name           = "my-state-table"
billing_mode   = "PAY_PER_REQUEST"
hash_key       = "LockID"
```

## Security Considerations
- Ensure proper IAM permissions
- Monitor DynamoDB usage and costs
- Implement appropriate backup strategies

## Related Documentation
- [Terraform State Locking](https://www.terraform.io/docs/language/state/locking.html)
- [AWS DynamoDB Documentation](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html)

# Terraform Modules

This directory contains reusable Terraform modules for AWS infrastructure components.

## Module Structure

```
modules/
├── aws-vpc/                  # VPC and networking components
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
├── aws-ec2/                  # EC2 instance configurations
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
└── aws-security/            # Security configurations
    ├── main.tf
    ├── variables.tf
    └── outputs.tf
```

## Module Usage

### VPC Module Example
```hcl
module "vpc" {
  source = "./modules/aws-vpc"

  vpc_name     = "main-vpc"
  vpc_cidr     = "10.0.0.0/16"
  environment  = "production"
  
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}
```

### EC2 Module Example
```hcl
module "ec2" {
  source = "./modules/aws-ec2"

  instance_name = "web-server"
  instance_type = "t3.micro"
  subnet_id     = module.vpc.private_subnet_ids[0]
}
```

## Module Documentation

### Required Providers
```hcl
provider "aws" {
  region = "us-east-1"
  version = "~> 5.0"
}
```

### Common Variables
| Name | Description | Type | Required |
|------|-------------|------|----------|
| environment | Environment name | string | yes |
| region | AWS region | string | yes |
| tags | Resource tags | map(string) | no |

## Development Guidelines

1. **Module Structure**
   - Keep modules focused on single responsibility
   - Include README.md for each module
   - Standardize file naming (main.tf, variables.tf, outputs.tf)

2. **Versioning**
   - Tag modules with semantic versions
   - Document breaking changes
   - Maintain backwards compatibility where possible

3. **Testing**
   - Test modules independently
   - Validate all variables
   - Include example configurations

4. **Security Best Practices**
   - Enable encryption by default
   - Follow least privilege principle
   - Document security considerations

## Using These Modules

1. Reference module in your Terraform configuration:
```hcl
module "example" {
  source = "./modules/aws-vpc"
  // ... module variables
}
```

2. Initialize Terraform:
```bash
terraform init
```

3. Apply configuration:
```bash
terraform plan
terraform apply
```

## Contributing

1. Create feature branch
2. Make changes following guidelines
3. Test thoroughly
4. Update documentation
5. Submit pull request

## Module Maintenance

- Regular security updates
- AWS provider version updates
- Documentation updates
- Bug fixes and improvements