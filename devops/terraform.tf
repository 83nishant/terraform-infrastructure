terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0-beta1"
    }
  }

  backend "s3" {
    bucket = "798-nishant"
    key = "terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "my-state-table"
  }
}