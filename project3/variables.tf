variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-west-1"
}

variable "access_key" {
  description = "AWS access key (from terraform.tfvars, never committed)"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "AWS secret key (from terraform.tfvars, never committed)"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the key pair registered in AWS"
  type        = string
  default     = "project3-demo-key"
}

variable "private_key_path" {
  description = "Local private key used by remote-exec to SSH in"
  type        = string
  default     = "~/.ssh/terraform-key"
}
