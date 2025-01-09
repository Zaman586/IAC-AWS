# Provider Configuration
provider "aws" {
  region     = "us-east-1"  # Default region
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
}

# VPC ID (Explicitly mention your VPC ID)
resource "aws_security_group" "allow_all" {
  vpc_id      = "vpc-0c94ff138dc12f1ac"  # Replace with your VPC ID
  name_prefix = "allow_all_"
  description = "Allow inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all incoming traffic (be cautious with this)
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outgoing traffic
  }

  tags = {
    Name = "AllowAllSecurityGroup"
  }
}

# Create an EC2 instance (VM) with updated instance type and VPC configuration
resource "aws_instance" "example" {
  ami           = "ami-0e2c8caa4b6378d8c"  # Amazon Linux 2 AMI (compatible with t3.micro)
  instance_type = "t3.micro"               # Changed to t3.micro, supports UEFI and Nitro System

  # Use the existing SSH key pair in AWS (replace with your key name)
  key_name      = "key-0666aeaf890d629b0"

  # Associate the security group with the instance
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  subnet_id = "subnet-08d6da63096114956"  # Replace with a valid subnet ID from your VPC

  tags = {
    Name = "ExampleInstance"
  }
}
