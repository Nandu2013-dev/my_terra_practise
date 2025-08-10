provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "name" {
    ami = "ami-0de716d6197524dd9"
    instance_type = "t2.nano"
    availability_zone = "us-east-1a"
    tags = {
        Name = "dev"
    }
}

resource "aws_s3_bucket" "name" { //terraform plan/apply -target=aws_s3_bucket.name 
    bucket = "fgfdgffregfhghg"    //to plan only this S3 resource which does not include above "ec2"
}
