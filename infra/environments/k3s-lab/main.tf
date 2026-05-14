data "aws_instance" "server" {
  instance_id = var.k3s_server_instance_id
}

data "aws_instance" "agent" {
  instance_id = var.k3s_agent_instance_id
}

module "k3s_security_group" {
  source = "../../modules/k3s_security_group"

  project_name = var.project_name

  vpc_id = data.aws_subnet.server.vpc_id
  
  k3s_server_network_interface_id = data.aws_instance.server.network_interface[0].network_interface_id
  k3s_agent_network_interface_id  = data.aws_instance.agent.network_interface[0].network_interface_id

  allowed_public_ip_cidr = var.allowed_public_ip_cidr

  tags = {
    Environment = "lab"
  }
}