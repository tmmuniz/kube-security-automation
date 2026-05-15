variable "project_name" {
  type        = string
}

variable "vpc_id" {
  type        = string
}

variable "k3s_server_network_interface_id" {
  type        = string
}

variable "k3s_agent_network_interface_id" {
  type        = string
}

variable "allowed_public_ip_cidr" {
  type        = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "arn_oidc_ansible_role" {
  description = "GitHub Actions Ansible OIDC role ARN"
  type        = string
}

variable "adm_bucket_name" {
  description = "Existing private administrative bucket name"
  type        = string
}