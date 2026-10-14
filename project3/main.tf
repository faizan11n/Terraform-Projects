terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

data "aws_vpc" "default" {
  default = true
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_key_pair" "demo_key" {
  key_name   = var.key_name
  public_key = file("${var.private_key_path}.pub")
}

resource "aws_security_group" "ssh_sg" {
  name        = "project3-ssh-sg"
  description = "Allow SSH access"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "project3-ssh-sg"
  }
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.demo_key.key_name
  vpc_security_group_ids = [aws_security_group.ssh_sg.id]

  tags = {
    Name = "Terraform-Project-3"
  }

  # How Terraform logs in to the new server
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file(var.private_key_path)
    timeout     = "5m"
  }

  # Runs ON the new server after it boots: installs Git + Ansible
  provisioner "remote-exec" {
    inline = [
      "sudo dnf install -y git python3-pip",
      "sudo dnf install -y ansible-core || sudo pip3 install ansible-core",
      "git --version",
      "ansible --version | head -n 1",
    ]
  }
}
