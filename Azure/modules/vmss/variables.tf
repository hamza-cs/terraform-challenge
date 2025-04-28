variable "vm_config" {
  description = "Configuration block for the Virtual Machine Scale Set"
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
  description = "Configuration for mounting Azure file share"
  type = object({
    mount_path      = string
    file_share_name = string
    storage_account = string
    account_key     = string
  })
}

variable "backend_pool_id" {
  description = "ID of the load balancer backend pool"
  type        = string
}
