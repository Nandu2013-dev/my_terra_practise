provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_user" "my_user" {
      # Leave this empty for now. Terraform needs the block to exist to allow import.
  name = "ganesh"
}

# Important: The resource name (my_user) is Terraform's internal name. 
# The IAM username (ganesh) must match exactly what you created in AWS.
# "terraform import aws_iam_user.my_user ganesh"
#  terraform validate followed by plan
# terraform apply will make the changes, if aany modifications done in the above example