# Provider Configuration
provider "aws" {
  region = "us-east-1"
}

# VPC ID (Explicitly mention your VPC ID)
resource "aws_security_group" "allow_all" {
  vpc_id      = var.vpc_id
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
  key_name      = var.key_name

  # Associate the security group with the instance
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  subnet_id = var.subnet_id  # Replace with a valid subnet ID from your VPC

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name  # Attach the IAM role

  tags = {
    Name = "ExampleInstance"
  }
}

# IAM Role and Instance Profile
resource "aws_iam_role" "ec2_role" {
  name = "MyEC2Role"
  assume_role_policy = file("trust_policy.json")
}

resource "aws_iam_role_policy" "ec2_policy" {
  name   = "MyEC2Policy"
  role   = aws_iam_role.ec2_role.id
  policy = file("policy.json")
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "MyEC2InstanceProfile"
  role = aws_iam_role.ec2_role.name
}
