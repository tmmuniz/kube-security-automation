output "k3s_security_group_id" {
  value = aws_security_group.k3s_nodes.id
}

output "k3s_server_public_ip" {
  value = data.aws_instance.k3s_server.public_ip
}

output "k3s_server_private_ip" {
  value = data.aws_instance.k3s_server.private_ip
}

output "k3s_agent_private_ip" {
  value = data.aws_instance.k3s_agent.private_ip
}