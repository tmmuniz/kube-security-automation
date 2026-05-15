output "k3s_security_group_id" {
  value = module.k3s_security_group.security_group_id
}

output "k3s_server_public_ip" {
  value = data.aws_instance.server.public_ip
}

output "k3s_server_private_ip" {
  value = data.aws_instance.server.private_ip
}

output "k3s_agent_private_ip" {
  value = data.aws_instance.agent.private_ip
}

output "k3s_server_primary_eni_id" {
  value = data.aws_network_interface.server_primary.id
}

output "k3s_agent_primary_eni_id" {
  value = data.aws_network_interface.agent_primary.id
}

output "trivy_reports_s3_prefix" {
  value = "s3://${var.adm_bucket_name}/trivy-reports/"
}