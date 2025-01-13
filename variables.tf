# variables.tf

variable "AWS_ACCESS_KEY_ID" {
  description = "The AWS access key ID"
  type        = string
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "The AWS secret access key"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
  default     = "vpc-0c94ff138dc12f1ac"  # Replace with your VPC ID
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = string
  default     = "subnet-08d6da63096114956"  # Replace with your subnet ID
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
  default     = "keypairterraform"  # Replace with your key pair name
}
