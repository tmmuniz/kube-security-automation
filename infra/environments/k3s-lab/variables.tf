variable "aws_region" {
  type = string
}

variable "project_name" {
  type    = string
  default = "cloud-security-automation"
}

variable "k3s_server_instance_id" {
  type = string
}

variable "k3s_agent_instance_id" {
  type = string
}

variable "allowed_public_ip_cidr" {
  type = string
}