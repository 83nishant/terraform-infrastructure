resource "aws_s3_bucket" "remote_s3" {
  bucket = "798-nishant"

  tags = {
    Name = "my-bucket"
  }
}