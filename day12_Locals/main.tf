provider "aws" {
  region = "us-east-1"
}

# Define reusable values
locals {
  name_prefix = "${var.project}-${var.environment}"
  instance_name = "${local.name_prefix}-web"

  tags = {
    Name        = local.instance_name
    Environment = var.environment
    Project     = var.project
    Owner       = "DevOps Team"
  }
}

# EC2 instance using locals and variables
resource "aws_instance" "web" {
  ami           = "ami-00ca32bbc84273381" # Amazon Linux 2 AMI
  instance_type = var.instance_type

  tags = local.tags
}
