# provider "aws"{
#   region     = "us-east-1"
# }

#### below code is to upgrade or downgrade a terraform version
################### terraform init -upgrade  -to upgrade
########## leads to version change in .terraform.lock.hcl to 4.0
terraform {
  required_version = "~> 1.12.2"  #this allows if terrafrom version in local 1.12.2 only 
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.0"  #if you want to upgrade/downgrade the version change it here and run terraform init -upgrade so that lock will release allow to download specific version 
    }
  }
}


provider "aws" {
  # Configuration options
  region     = "us-east-1"
}