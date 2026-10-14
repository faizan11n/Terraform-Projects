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
  default     = "project4-demo-key"
}

variable "server_names" {
  description = "One EC2 instance is created per name in this set"
  type        = set(string)
  default     = ["web1", "web2", "web3"]
}
