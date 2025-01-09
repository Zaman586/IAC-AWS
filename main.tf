# Provider Configuration
provider "aws" {
  region = "us-east-1"  # Default region
}

# Create a Security Group
resource "aws_security_group" "allow_all" {
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

# Create an EC2 instance (VM)
resource "aws_instance" "example" {
  ami           = "ami-0c02fb55956c7d316"  # Amazon Linux 2 AMI (compatible with t2.micro)
  instance_type = "t2.micro"               # Free tier-eligible instance type

  # Use the existing SSH key pair in AWS (replace with your key name)
  key_name      = "key-049413711"

  # Associate the security group with the instance
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "ExampleInstance"
  }
}
