# AWS EKS Cluster Infrastructure

This directory contains Terraform configurations for deploying and managing Amazon EKS (Elastic Kubernetes Service) clusters.

## Infrastructure Components

### EKS Cluster
- Managed Kubernetes control plane
- Multi-AZ deployment for high availability
- Kubernetes version: 1.27
- API server endpoint encryption
- Managed node groups configuration

### Node Groups
- Auto-scaling worker nodes
- Instance types: t3.medium
- Custom AMI support
- Node labels and taints
- Spot instance support for cost optimization

### Networking
- VPC with private/public subnets
- Security groups for cluster components
- Load balancer configuration
- Service mesh integration

## Prerequisites

- Terraform >= 1.0.0
- AWS CLI configured with appropriate permissions
- kubectl installed locally
- Access to remote state bucket (798-nishant)
- Access to state locking table (my-state-table-new)

## Directory Structure

```
eks-cluster/
├── main.tf           # Main cluster configuration
├── variables.tf      # Input variables
├── outputs.tf        # Output values
├── provider.tf       # AWS provider configuration
├── vpc.tf           # VPC and networking setup
└── node-groups.tf   # Worker node configurations
```

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review planned changes:
```bash
terraform plan
```

3. Apply configuration:
```bash
terraform apply
```

4. Configure kubectl:
```bash
aws eks update-kubeconfig --name <cluster-name> --region us-east-1
```

## Remote State Configuration

```hcl
terraform {
  backend "s3" {
    bucket         = "798-nishant"
    key            = "eks-cluster/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-state-table-new"
    encrypt        = true
  }
}
```

## Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| cluster_name | EKS cluster name | string | eks-demo |
| cluster_version | Kubernetes version | string | 1.27 |
| vpc_cidr | VPC CIDR block | string | 10.0.0.0/16 |
| node_instance_type | Worker node instance type | string | t3.medium |

## Outputs

| Name | Description |
|------|-------------|
| cluster_endpoint | EKS cluster API endpoint |
| cluster_name | Name of the EKS cluster |
| kubeconfig | kubeconfig for cluster access |

## Security Best Practices

1. Private API server endpoint
2. Node groups in private subnets
3. IAM roles for service accounts (IRSA)
4. Network policies enabled
5. Control plane logging enabled

## Monitoring and Maintenance

- CloudWatch logs integration
- Prometheus metrics collection
- Horizontal Pod Autoscaling
- Node group updates strategy
- Backup and disaster recovery procedures

## Documentation References
- [Amazon EKS Documentation](https://docs.aws.amazon.com/eks/latest/userguide/what-is-eks.html)
- [Terraform AWS EKS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)
- [kubectl Documentation](https://kubernetes.io/docs/reference/kubectl/)
