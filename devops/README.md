# DevOps Infrastructure

This directory contains Terraform configurations for managing DevOps infrastructure components in AWS.

## Infrastructure Components

### VPC Configuration
- Custom VPC with public/private subnets
- NAT Gateways for private subnet connectivity
- Internet Gateway for public access
- Route tables and network ACLs

### EC2 Resources
- Application servers in private subnets
- Bastion hosts in public subnets
- Auto-scaling groups for high availability
- Load balancers for traffic distribution

### Security Components
- IAM roles and policies
- Security groups with least privilege access
- KMS keys for encryption
- SSL/TLS certificates management

## Prerequisites

- Terraform >= 1.0.0
- AWS CLI configured
- AWS credentials with appropriate permissions
- Access to remote state bucket (798-nishant)
- Access to state locking table (my-state-table-new)

## Directory Structure

```
devops/
├── main.tf           # Main infrastructure configuration
├── variables.tf      # Input variables definition
├── outputs.tf        # Output values
├── provider.tf       # AWS provider configuration
├── vpc.tf           # VPC and networking components
├── ec2.tf           # EC2 instance configurations
└── security.tf      # Security group and IAM configurations
```

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the execution plan:
```bash
terraform plan
```

3. Apply the changes:
```bash
terraform apply
```

4. Clean up resources:
```bash
terraform destroy
```

## Remote State Configuration

```hcl
terraform {
  backend "s3" {
    bucket         = "798-nishant"
    key            = "devops/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-state-table-new"
    encrypt        = true
  }
}
```

## Common Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| environment | Environment name | string | dev |
| region | AWS region | string | us-east-1 |
| vpc_cidr | VPC CIDR block | string | 10.0.0.0/16 |
| instance_type | EC2 instance type | string | t3.micro |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC identifier |
| public_subnet_ids | List of public subnet IDs |
| private_subnet_ids | List of private subnet IDs |
| instance_ids | List of EC2 instance IDs |

## Security Best Practices

1. All resources are deployed in private subnets by default
2. Security groups follow least privilege principle
3. All data in transit and at rest is encrypted
4. Regular security patches through automated updates
5. Access logs enabled for audit trails

## Maintenance

- Regular infrastructure updates
- Security patch management
- Backup and disaster recovery
- Performance monitoring
- Cost optimization

## Related Documentation
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts.html)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)