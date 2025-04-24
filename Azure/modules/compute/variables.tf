variable "config" {
  description = "VM configuration block"
  type = object({
    vmname        = string
    location      = any
    rgname        = string
    subnet_id     = any
    vmsize        = string
    adminuser     = string
    adminpassword = string
    image = object({
      publisher = string
      offer     = string
      sku       = string
    })
    tags = map(string)
  })
}

variable "mount_config" {
  description = "Information for mounting Azure file share"
  type = object({
    mount_path      = string
    file_share_name = string
    storage_account = string
    account_key     = string
  })
}

variable "backend_pool_id" {
  
}