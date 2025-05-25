resource "aws_s3_bucket" "remote_s3" {
  bucket        = "798-nishant"
  force_destroy = true  # Added to allow bucket deletion with objects

  tags = {
    Name        = "my-bucket"
    Environment = "Production"
  }
}

# Enable versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.remote_s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enable encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.remote_s3.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}