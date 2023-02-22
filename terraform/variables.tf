variable "resource_group_location" {
  default     = "westus3"
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  default     = "projfin-group3"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}
