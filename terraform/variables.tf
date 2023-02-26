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

variable "metallb_first_ip" {
  default = "10.187.0.0"
}
