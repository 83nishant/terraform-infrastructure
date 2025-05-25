#dev infra

module "dev-infra" {
  source = "./infra-app"
  env = "dev"
  bucket_name = "infra-app-bucket"
  instance_count = 1
  instance_type = "t2.micro"
  ec2_ami_id = "ami-06c8f2ec674c67112"
  hash_key = "studentid"

}

#prod infra

module "prod-infra" {
  source = "./infra-app"
  env = "prod"
  bucket_name = "infra-app-bucket"
  instance_count = 2
  instance_type = "t2.medium"
  ec2_ami_id = "ami-06c8f2ec674c67112"
  hash_key = "studentid"

}

#staging infra

module "staging-infra" {
  source = "./infra-app"
  env = "staging"
  bucket_name = "infra-app-bucket"
  instance_count = 1
  instance_type = "t2.small"
  ec2_ami_id = "ami-06c8f2ec674c67112"
  hash_key = "studentid"

}



