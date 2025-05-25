resource "aws_s3_bucket" "remote_s3" {
  bucket = "${var.env}-${var.bucket_name}-${random_id.bucket_suffix.hex}"

  tags = {
    Name = "my-bucket"
    Environment = var.env
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}