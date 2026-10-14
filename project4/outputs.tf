# Map: { web1 = "x.x.x.x", web2 = "...", web3 = "..." }
output "server_public_ips" {
  description = "Public IP of every server, keyed by server name"
  value       = { for name, inst in aws_instance.web : name => inst.public_ip }
}
