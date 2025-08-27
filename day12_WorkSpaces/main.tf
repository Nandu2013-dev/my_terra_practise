provider "aws" {
  region  = "us-east-1"
  profile = "default"  # or whatever matches your config
}
resource "aws_s3_bucket" "example" {
  bucket = "my-terraform-bucket-${terraform.workspace}-bb-20250826"
  tags = {
    Environment = terraform.workspace
  }
}
# resource "aws_s3_bucket_acl" "example_acl" {
#   bucket = aws_s3_bucket.example.id
#   acl    = "private"
# }