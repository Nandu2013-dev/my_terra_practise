provider "aws" {
  region = "us-east-1"
}

# 1. IAM Role for EC2
resource "aws_iam_role" "ec2_role" {
  name = "ec2-full-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# 2. Attach AmazonEC2FullAccess Policy to Role
resource "aws_iam_role_policy_attachment" "ec2_full_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# 3. Create Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2-full-access-profile"
  role = aws_iam_role.ec2_role.name
}

# 4. Launch EC2 Instance (uses default subnet & security group)
resource "aws_instance" "ec2_instance" {
  ami                    = "ami-084a7d336e816906b"  # Amazon Linux 2 in us-east-1
  instance_type          = "t3.micro"
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name = "MinimalEC2WithIAMRole"
  }
}
