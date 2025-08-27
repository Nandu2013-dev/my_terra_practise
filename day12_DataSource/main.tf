# data "aws_ami" "amazon_linux" {
#   most_recent = true
#   owners      = ["amazon"]

#   filter {
#     name   = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#   }
# }

# output "latest_ami_id" {
#   value = data.aws_ami.amazon_linux.id
# }

# resource "aws_instance" "example" {
#   ami           = data.aws_ami.amazon_linux.id
#   instance_type = "t2.micro"
# }

data "aws_vpc" "default" {
  default = true
}

output "default_vpc_id" {
  value = data.aws_vpc.default.id
}
