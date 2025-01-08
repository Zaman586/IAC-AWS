# main.tf

# Provider Configuration
provider "aws" {
  region = "us-east-1"  # Adjust the region as needed
}

# Create a Security Group
resource "aws_security_group" "allow_all" {
  name_prefix = "allow_all_"
  description = "Allow inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EC2 instance (VM)
resource "aws_instance" "example" {
  ami           = "ami-002eb7d3c51508be5"  # Updated to FreeBSD 15.0-CURRENT-arm64-20240822 AMI ID
  instance_type = "t2.micro"  # Instance type can be adjusted based on your requirements

  # Use the existing SSH key pair in AWS (replace with your key name)
  key_name      = "key-049413711
