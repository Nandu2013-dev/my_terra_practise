# Provider for us-east-1 (for EC2 instance)
provider "aws" {
  alias  = "east1"
  region = "us-east-1"
}

# Provider for eu-north-1 (for S3 bucket)
provider "aws" {
  alias  = "west1"
  region = "us-west-1"
}

# EC2 instance in us-east-1
resource "aws_instance" "web" {
  provider      = aws.east1
  ami           = "ami-00ca32bbc84273381" # Amazon Linux 2 (example)
  instance_type = "t2.micro"

  tags = {
    Name = "Multi-Provider-Instance"
  }
}

# S3 bucket in eu-north-1
resource "aws_s3_bucket" "backup" {
  provider = aws.west1
  bucket   = "my-cross-region-bucket-20250826"  # Must be globally unique

  tags = {
    Name = "Cross-Region-Bucket"
  }
}
