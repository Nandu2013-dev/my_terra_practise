provider "aws" {
  region = "us-east-1"
}
# Creation of VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-gan"
  }
}

# Creation of subnets
resource "aws_subnet" "my_publicsubnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "gan-subnet-Pub"
  }
}

# Creation IG and attach to vpc
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "gan-igw"
  }
}

# Creation of route table and edit routes 
resource "aws_route_table" "my_pubrt" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Creation of subnet associations 
resource "aws_route_table_association" "my_pubrt_assoc" {
  subnet_id      = aws_subnet.my_publicsubnet.id
  route_table_id = aws_route_table.my_pubrt.id
}

# Creation Security Group
resource "aws_security_group" "my_sg" {
  name   = "allow_tls"
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "gan-sg"
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creation of server
resource "aws_instance" "my_ec2_pubserver" {
  ami                    = "ami-0de716d6197524dd9"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.my_publicsubnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  associate_public_ip_address = true 
  key_name = aws_key_pair.deployer.key_name
  tags = {
    Name = "gan-ec2-pub-server"
  }
}


resource "aws_subnet" "my_privatesubnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "gan-subnet-Pvt"
  }
}

# Elastic IP for NAT
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT Gateway (in public subnet)
resource "aws_nat_gateway" "my_nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.my_publicsubnet.id #public subnet remember
  }

# Route Table for Private Subnet (uses NAT)
resource "aws_route_table" "my_pvtrt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gw.id
  }
}

resource "aws_route_table_association" "my_pvtrt_assoc" {
  subnet_id      = aws_subnet.my_privatesubnet.id
  route_table_id = aws_route_table.my_pvtrt.id
}

# Creation of server
resource "aws_instance" "my_ec2_pvt_server" {
  ami                    = "ami-0de716d6197524dd9"
  instance_type          = "t3.nano"
  subnet_id              = aws_subnet.my_privatesubnet.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  key_name = aws_key_pair.deployer.key_name
  # associate_public_ip_address = true 
  tags = {
    Name = "gan-ec2-pvt-server"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "mykey"
  public_key = file("mykey.pub")
}