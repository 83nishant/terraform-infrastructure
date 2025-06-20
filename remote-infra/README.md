# Remote Infrastructure

This directory contains Terraform configurations for managing remote state infrastructure components in AWS.

## Components

### S3 Bucket (State Storage)
- **Name**: `798-nishant`
- **Purpose**: Remote state storage for Terraform
- **Features**:
  - Versioning enabled
  - Server-side encryption (AES-256)
  - Lifecycle management
  - Prevent accidental deletion

### DynamoDB Table (State Locking)
- **Name**: `my-state-table-new`
- **Purpose**: State locking mechanism
- **Configuration**:
  - Billing Mode: PAY_PER_REQUEST
  - Hash Key: LockID
  - Attributes: LockID (String)

## Prerequisites

- AWS CLI configured
- Terraform >= 1.0
- AWS credentials with permissions for:
  - S3 bucket management
  - DynamoDB table management

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Import existing S3 bucket (if not already done):
```bash
terraform import aws_s3_bucket.remote_s3 798-nishant
```

3. Apply configuration:
```bash
terraform plan
terraform apply
```

## File Structure

```
remote-infra/
├── s3.tf           # S3 bucket configuration
├── dynamodb.tf     # DynamoDB table configuration
├── provider.tf     # AWS provider configuration
└── terraform.tf    # Terraform settings
```

## Security Considerations

- Bucket versioning enabled
- Server-side encryption enabled
- Public access blocked
- Resource deletion protection enabled
- IAM policies follow least privilege principle

## State Configuration

```hcl
terraform {
  backend "s3" {
    bucket         = "798-nishant"
    key            = "remote-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-state-table-new"
    encrypt        = true
  }
}
```

## Resource Details

### S3 Bucket Properties
- Versioning: Enabled
- Encryption: AES-256
- Public Access: Blocked
- Lifecycle Rules: Configured for state files

### DynamoDB Table Properties
- Billing Mode: Pay-per-request
- Primary Key: LockID (String)
- Region: us-east-1

## Maintenance

- Regular backup verification
- Access log monitoring
- Cost optimization reviews
- Security compliance checks

## Important Notes

1. Do not delete these resources while in use by other Terraform configurations
2. Keep backup of state files
3. Monitor DynamoDB capacity usage
4. Review access logs regularly

## Related Documentation
- [Terraform Backend Configuration](https://www.terraform.io/docs/language/settings/backends/s3.html)
- [AWS S3 Documentation](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
- [AWS DynamoDB Documentation](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/Introduction.html)