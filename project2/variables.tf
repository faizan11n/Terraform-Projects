variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-west-1"
}

variable "access_key" {
  description = "AWS access key (sensitive - comes from terraform.tfvars, never committed)"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "AWS secret key (sensitive - comes from terraform.tfvars, never committed)"
  type        = string
  sensitive   = true
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name to register the SSH key pair under in AWS"
  type        = string
  default     = "project2-demo-key"
}
