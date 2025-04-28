variable "network_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "network_address_space" {
  description = "Address space for the Virtual Network"
  type        = list(string)
}

variable "region" {
  description = "The Azure region where the resources will be created"
  type        = string
}

variable "resource_group" {
  description = "Name of the resource group where the network will be deployed"
  type        = string
}

variable "resource_tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
}

variable "subnet_configs" {
  description = "Map of subnets with address prefixes"
  type = map(object({
    address_prefixes = list(string)
  }))
}
