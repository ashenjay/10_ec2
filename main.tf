provider "aws" {
  region = var.region
}

# Define a VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main-vpc"
  }
}

# Define a subnet within the VPC
resource "aws_subnet" "main_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"  # You can choose any availability zone in us-east-1

  tags = {
    Name = "main-subnet"
  }
}

# Create a security group that allows all traffic
resource "aws_security_group" "allow_all" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "allow_all_traffic"
  description = "Security group that allows all inbound and outbound traffic"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create 10 EC2 instances in the specified subnet
resource "aws_instance" "ec2_instances" {
  count         = var.instance_count
  ami           = "ami-0ae8f15ae66fe8cda"  # Example AMI ID, change as needed
  instance_type = "t2.micro"

  key_name               = var.key_name
  subnet_id              = aws_subnet.main_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "Jenkins-EC2-${count.index}"
  }
}

output "instance_ids" {
  value = aws_instance.ec2_instances[*].id
}
