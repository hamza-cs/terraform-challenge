variable "region" {
  description = "Azure region"
  type        = string
}

variable "rg_name" {
  description = "Resource Group name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

# Network
variable "vnet_name" {
  type = string
}

variable "address_space" {
  type = list(string)
}

variable "subnets" {
  type = map(object({
    address_prefixes = list(string)
  }))
}

# Load Balancer
variable "lb_name" {
  type = string
}

variable "backend_pool_name" {
  type = string
}

variable "frontend_port" {
  type = number
}

variable "backend_port" {
  type = number
}

variable "probe_path" {
  type = string
}

# Storage
variable "storage_prefix" {
  type = string
}

variable "account_tier" {
  type = string
}

variable "replication_type" {
  type = string
}

variable "file_share_config" {
  type = map(any)
}

# Compute
variable "vm_name" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "admin_password" {
  type      = string
  sensitive = true
}

variable "vm_image_publisher" {
  type = string
}

variable "vm_image_offer" {
  type = string
}

variable "vm_image_sku" {
  type = string
}
