provider "aws" {
  region = "us-east-1"
}

# data "aws_vpc" "default" {
#   default = true
# }

# ----------------------------
# LOCALS
# ----------------------------
locals {
  inbound_rules = [
    { port = 22, description = "SSH" },
    { port = 80, description = "HTTP" }
  ]

  outbound_rules = [
    { port = 443, description = "HTTPS" },
    { port = 8080, description = "App traffic" }
  ]

  cidr_block = "10.1.0.0/16"
}

# ----------------------------
# USE DEFAULT VPC
# ----------------------------
data "aws_vpc" "default" {
  default = true
}

# ----------------------------
# SECURITY GROUP
# ----------------------------
resource "aws_security_group" "example_sg_new" {
  name        = "example-sg"
  description = "Allow specific ports for inbound and outbound"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "example-security-group"
  }
}

# ----------------------------
# INBOUND RULES
# ----------------------------
resource "aws_security_group_rule" "inbound_rules" {
  for_each = { for idx, rule in local.inbound_rules : idx => rule }

  type              = "ingress"
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = "tcp"
  cidr_blocks       = [local.cidr_block]
  description       = each.value.description
  security_group_id = aws_security_group.example_sg_new.id
}

# ----------------------------
# OUTBOUND RULES
# ----------------------------
resource "aws_security_group_rule" "outbound_rules" {
  for_each = { for idx, rule in local.outbound_rules : idx => rule }

  type              = "egress"
  from_port         = each.value.port
  to_port           = each.value.port
  protocol          = "tcp"
  cidr_blocks       = [local.cidr_block]
  description       = each.value.description
  security_group_id = aws_security_group.example_sg_new.id
}
