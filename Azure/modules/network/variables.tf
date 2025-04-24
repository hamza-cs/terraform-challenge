variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "region" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
}
