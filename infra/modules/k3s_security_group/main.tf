resource "aws_security_group" "this" {
  name        = "${var.project_name}-k3s-nodes-sg"
  description = "Security group for K3s nodes"
  vpc_id      = var.vpc_id

  tags = merge(
    {
      Name    = "${var.project_name}-k3s-nodes-sg"
      Project = var.project_name
    },
    var.tags
  )
}

resource "aws_vpc_security_group_ingress_rule" "api_external" {
  security_group_id = aws_security_group.this.id
  ip_protocol = "tcp"
  from_port   = 6443
  to_port     = 6443
  cidr_ipv4   = var.allowed_public_ip_cidr
}

resource "aws_vpc_security_group_ingress_rule" "api_internal" {
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = aws_security_group.this.id
  ip_protocol = "tcp"
  from_port   = 6443
  to_port     = 6443
}

resource "aws_vpc_security_group_ingress_rule" "kubelet" {
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = aws_security_group.this.id
  ip_protocol = "tcp"
  from_port   = 10250
  to_port     = 10250
}

resource "aws_vpc_security_group_ingress_rule" "flannel" {
  security_group_id            = aws_security_group.this.id
  referenced_security_group_id = aws_security_group.this.id
  ip_protocol = "udp"
  from_port   = 8472
  to_port     = 8472
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_network_interface_sg_attachment" "server" {
  security_group_id    = aws_security_group.this.id
  network_interface_id = var.k3s_server_network_interface_id
}

resource "aws_network_interface_sg_attachment" "agent" {
  security_group_id    = aws_security_group.this.id
  network_interface_id = var.k3s_agent_network_interface_id
}