
provider "aws" {
  region = "us-east-1"
}

# DB Subnet Group
resource "aws_db_subnet_group" "dev_db_my_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = [
    "subnet-056b246061f73eb41",
    "subnet-08fc4acc8b183d2f7"
  ]
  tags = {
    Name = "dev-db-subnet-group"
  }
}

# Security Group for RDS
resource "aws_security_group" "dev_rds_sg" {
  name   = "dev-rds-sg"
  vpc_id = "vpc-029edb1bc3cef1fb6"
  tags = {
    Name = "dev-rds-sg"
  }

  # Allow MySQL traffic from application SG
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "TCP"
   
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# RDS MySQL Instance
resource "aws_db_instance" "dev_rds" {
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  db_name                = "devdb"
  username               = "admin"
  password               = "StrongPassw0rd!"
  skip_final_snapshot    = true
  publicly_accessible    = true

  db_subnet_group_name   = aws_db_subnet_group.dev_db_my_subnet_group.name
  vpc_security_group_ids = [aws_security_group.dev_rds_sg.id]
  depends_on = [ aws_db_subnet_group.dev_db_my_subnet_group ]

  tags = {
    Name = "dev-rds"
  }
}
