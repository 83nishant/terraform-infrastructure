variable "env" {
  description = "This is env for my infra"
  type = string
}

variable "bucket_name" {
  description = "this is bucket name for my infra"
  type = string
}

variable "instance_count" {
  description = "this is my ec2 instance count"
  type = number
}

variable "instance_type" {
  description = "this is instance type"
  type = string
}

variable "ec2_ami_id" {
  description = "this is ami id"
  type = string
}

variable "hash_key" {
  description = "this is hask-key"
  type = string
}