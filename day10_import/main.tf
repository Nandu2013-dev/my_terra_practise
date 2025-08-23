provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami = "ami-00ca32bbc84273381"
  instance_type = "t3.micro"
  # Leave this empty for now. Terraform needs the block to exist to allow import.
}

# aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --output json
# Above command will extract instanceID from AWS account for example "i-01d7f4514fc0cb777"
# Use below command to import and see tfstate file 
# "terraform import aws_instance.example i-01d7f4514fc0cb777"
# try "terraform plan" and will see some rerrors
# "terraform show" command gives complete details of imported instance
#  fill resource "aws_instance" "example" with the instance details, initially it was empty
#  terraform validate followed by plan
# terraform apply will make the changes, if sny modifications done in the above example