terraform {
  backend "s3" {
    bucket = "gantests33"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}