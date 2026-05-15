data "aws_instance" "server" {
  instance_id = var.k3s_server_instance_id
}

data "aws_instance" "agent" {
  instance_id = var.k3s_agent_instance_id
}

data "aws_network_interface" "server_primary" {
  filter {
    name   = "attachment.instance-id"
    values = [var.k3s_server_instance_id]
  }

  filter {
    name   = "attachment.device-index"
    values = ["0"]
  }
}

data "aws_network_interface" "agent_primary" {
  filter {
    name   = "attachment.instance-id"
    values = [var.k3s_agent_instance_id]
  }

  filter {
    name   = "attachment.device-index"
    values = ["0"]
  }
}

module "k3s_security_group" {
  source = "../../modules/k3s_security_group"

  project_name = var.project_name

  vpc_id = data.aws_network_interface.server_primary.vpc_id

  k3s_server_network_interface_id = data.aws_network_interface.server_primary.id
  k3s_agent_network_interface_id  = data.aws_network_interface.agent_primary.id

  allowed_public_ip_cidr = var.allowed_public_ip_cidr

  

  tags = {
    Environment = "lab"
    ManagedBy   = "Terraform"
    Component   = "K3s"
  }
}