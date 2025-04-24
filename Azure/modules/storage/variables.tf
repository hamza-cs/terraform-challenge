variable "region" {
  description = "Azure region"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "storage_config" {
  description = "Map containing configurable values for the storage account"
  type = object({
    prefix           = string
    account_tier     = string
    replication_type = string
    tags = map(string)
  })
}

variable "file_share_config" {
  description = "Map for file share configuration"
  type        = map(any)
}