provider "aws" {
  region = var.aws_region
}

data "aws_instance" "k3s_server" {
  instance_id = var.k3s_server_instance_id
}

data "aws_instance" "k3s_agent" {
  instance_id = var.k3s_agent_instance_id
}

resource "aws_security_group" "k3s_nodes" {
  name        = "${var.project_name}-k3s-nodes-sg"
  description = "Security group for K3s nodes"
  vpc_id      = data.aws_instance.k3s_server.vpc_id

  tags = {
    Name    = "${var.project_name}-k3s-nodes-sg"
    Project = var.project_name
  }
}

resource "aws_vpc_security_group_ingress_rule" "k3s_api_external" {
  security_group_id = aws_security_group.k3s_nodes.id
  ip_protocol = "tcp"
  from_port   = 6443
  to_port     = 6443
  cidr_ipv4   = var.allowed_public_ip_cidr
}

resource "aws_vpc_security_group_ingress_rule" "k3s_api_internal" {
  security_group_id            = aws_security_group.k3s_nodes.id
  referenced_security_group_id = aws_security_group.k3s_nodes.id
  ip_protocol = "tcp"
  from_port   = 6443
  to_port     = 6443
}

resource "aws_vpc_security_group_ingress_rule" "kubelet_internal" {
  security_group_id            = aws_security_group.k3s_nodes.id
  referenced_security_group_id = aws_security_group.k3s_nodes.id
  ip_protocol = "tcp"
  from_port   = 10250
  to_port     = 10250
}

resource "aws_vpc_security_group_ingress_rule" "flannel_internal" {
  security_group_id            = aws_security_group.k3s_nodes.id
  referenced_security_group_id = aws_security_group.k3s_nodes.id
  ip_protocol = "udp"
  from_port   = 8472
  to_port     = 8472
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.k3s_nodes.id
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_network_interface_sg_attachment" "server" {
  security_group_id    = aws_security_group.k3s_nodes.id
  network_interface_id = data.aws_instance.k3s_server.primary_network_interface_id
}

resource "aws_network_interface_sg_attachment" "agent" {
  security_group_id    = aws_security_group.k3s_nodes.id
  network_interface_id = data.aws_instance.k3s_agent.primary_network_interface_id
}