provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "name" {
    ami = "ami-0de716d6197524dd9"
    instance_type = "t2.nano"
    availability_zone = "us-east-1a"
    user_data = file("somescript.sh") //this script will install the apache server
    tags = {
        Name = "myenv"
    }
}