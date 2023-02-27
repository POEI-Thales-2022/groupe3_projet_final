variable "resource_group_location" {
  default     = "westus3"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  default = "projet-final-groupe-3"
}

variable "image_publisher" {
  default = "Canonical"
}

variable "image_offer" {
  default = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  default = "22_04-lts-gen2"
}

variable "image_version" {
  default = "22.04.202302140"
}

variable "gitlab_dns" {
  default = "gitlab-ce"
}

variable "k8s_lb_dns" {
  default = "k8s-lb"
}

variable "bastion_dns" {
  default = "g3-bastion"
}
