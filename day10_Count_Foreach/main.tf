# main.tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  count         = length(var.instance_names)
  ami           = "ami-00ca32bbc84273381"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_names[count.index]
  }
}