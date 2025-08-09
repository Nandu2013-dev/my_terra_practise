terraform {
  backend "s3" {
    bucket = "gantests33" #prepare this S3 before use
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}