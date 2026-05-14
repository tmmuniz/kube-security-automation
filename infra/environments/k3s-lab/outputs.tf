output "k3s_security_group_id" {
  value = module.k3s_security_group.security_group_id
}

output "k3s_server_public_ip" {
  value = data.aws_instance.server.public_ip
}

output "k3s_agent_private_ip" {
  value = data.aws_instance.agent.private_ip
}