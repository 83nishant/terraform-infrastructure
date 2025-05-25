#key pair (login)
resource "aws_key_pair" "my_key" {
  key_name   = "terra-key-ec2"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPOATffTkecQaidK3rUh3MF8ovihypyKMOPtr1nGzkTk nsdeshmukh@nsdeshmukh2"
}

#VPC & Security Group 
resource "aws_default_vpc" "my_vpc" {

}

# Lookup all default subnets for the default VPC
#resource aws_default_subnet my_subnet {
#availability_zone = "us-east-1a"

#}

resource "aws_security_group" "my_security" {
  name        = "automate-sg"
  description = "this will add SG "
  vpc_id      = aws_default_vpc.my_vpc.id #interpolation


  #inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"

  }

  #outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "all access open outbound"
  }


}

#ec2 instance

resource "aws_instance" "my_instance" {
  for_each = tomap ({
    tws-micro = "t2.micro"
    tws-medium = "t2.medium"

  }) #meta argument

    depends_on = [ aws_security_group.my_security ]

  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security.name]
  instance_type   = each.value
  ami             = var.ec2_ami_id #ubunto
  user_data       = file("install_nginx.sh")

  root_block_device {
    volume_size = var.env =="prod" ? 20 : var.ec2_default_root_storage
    volume_type = "gp3"
  }

  tags = {
    Name = each.key
    Environment = var.env
  }

}