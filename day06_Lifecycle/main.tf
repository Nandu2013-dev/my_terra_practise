provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "name" {
    ami = "ami-0de716d6197524dd9"
    instance_type = "t3.nano"
    availability_zone = "us-east-1a"
    tags = {
        Name = "dev-new"
    }

    lifecycle {
      create_before_destroy = true
    #  prevent_destroy = true // prevents destroy
      ignore_changes = [ tags,]  // ignores any tag names while recreation when changed outside Terraform

    }
     
}
