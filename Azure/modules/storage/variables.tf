variable "location" {
  description = "The Azure region where the Storage Account will be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "storage_config" {
  description = "Configuration for the Storage Account"
  type = object({
    prefix           = string
    account_tier     = string
    replication_type = string
    tags             = map(string)
  })
}

variable "file_share_config" {
  description = "Configuration for the File Share"
  type = object({
    name  = string
    quota = number
  })
}
