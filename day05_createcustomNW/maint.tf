# Creation of VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-gan"
  }
}

# Creation of subnets
resource "aws_subnet" "my_subnet_1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.0.0/24"
  tags = {
    Name = "gan-subnet-1"
  }
}

resource "aws_subnet" "my_subnet_2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "gan-subnet-2"
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
resource "aws_route_table_association" "my_rt_assoc1" {
  subnet_id      = aws_subnet.my_subnet_1.id
  route_table_id = aws_route_table.my_pubrt.id
}

resource "aws_route_table_association" "my_rt_assoc2" {
  subnet_id      = aws_subnet.my_subnet_2.id
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
resource "aws_instance" "my_ec2_server" {
  ami                    = "ami-0de716d6197524dd9"
  instance_type          = "t2.nano"
  subnet_id              = aws_subnet.my_subnet_1.id
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  tags = {
    Name = "gan-ec2-server"
  }
}
