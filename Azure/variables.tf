# General
variable "region" {
  description = "The Azure region where resources will be deployed"
  type        = string
}

variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}

# Network
variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
}

variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets configuration"
  type = map(object({
    address_prefixes = list(string)
  }))
}

# Load Balancer
variable "lb_name" {
  description = "Load Balancer name"
  type        = string
}

variable "backend_pool_name" {
  description = "Backend Pool name for the Load Balancer"
  type        = string
}

variable "frontend_port" {
  description = "Frontend port for the Load Balancer"
  type        = number
}

variable "backend_port" {
  description = "Backend port for the Load Balancer"
  type        = number
}

variable "probe_path" {
  description = "Probe path for the health check"
  type        = string
}

# Storage
variable "storage_prefix" {
  description = "Prefix for the Storage Account name"
  type        = string
}

variable "account_tier" {
  description = "Storage Account tier"
  type        = string
}

variable "replication_type" {
  description = "Storage replication type"
  type        = string
}

variable "file_share_config" {
  description = "File share configuration"
  type = object({
    name  = string
    quota = number
  })
}

# Compute
variable "vm_name" {
  description = "Name for the VM Scale Set"
  type        = string
}

variable "vm_size" {
  description = "Size of the VM instances"
  type        = string
}

variable "admin_username" {
  description = "Admin username for VMs"
  type        = string
}

variable "admin_password" {
  description = "Admin password for VMs"
  type        = string
}

variable "vm_image_publisher" {
  description = "Publisher of the VM image"
  type        = string
}

variable "vm_image_offer" {
  description = "Offer of the VM image"
  type        = string
}

variable "vm_image_sku" {
  description = "SKU of the VM image"
  type        = string
}
