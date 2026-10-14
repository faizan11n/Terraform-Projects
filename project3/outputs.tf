output "instance_public_ip" {
  description = "Public IP of the new server"
  value       = aws_instance.web.public_ip
}

output "ssh_command" {
  description = "Command to log in and verify"
  value       = "ssh -i ~/.ssh/terraform-key ec2-user@${aws_instance.web.public_ip}"
}
