provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "name" {
    ami = "ami-0de716d6197524dd9"
    instance_type = "t3.micro"
    tags = {
      Name = "tf_ec2"
    }
  
}
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "ganvpc"
    }
  
}