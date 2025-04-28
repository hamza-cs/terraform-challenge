module "resource_group" {
  source = "./modules/rg"

  location            = var.region
  resource_group_name = var.rg_name
}

module "networking" {
  source = "./modules/networking"

  network_name          = var.vnet_name
  network_address_space = var.address_space
  region                = var.region
  resource_group        = module.resource_group.resource_group_name
  resource_tags         = var.tags
  subnet_configs        = var.subnets
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  lb_settings = {
    location            = var.region
    resource_group      = module.resource_group.resource_group_name
    load_balancer_name  = var.lb_name
    backend_pool_name   = var.backend_pool_name
    frontend_port       = var.frontend_port
    backend_port        = var.backend_port
    probe_path          = var.probe_path
    tags                = var.tags
  }
}

module "storage" {
  source = "./modules/storage"

  location            = var.region
  resource_group_name = module.resource_group.resource_group_name
  storage_config = {
    prefix           = var.storage_prefix
    account_tier     = var.account_tier
    replication_type = var.replication_type
    tags             = var.tags
  }
  file_share_config = var.file_share_config
}

module "vmss" {
  source = "./modules/vmss"

  vm_config = {
    vmname        = var.vm_name
    location      = var.region
    rgname        = module.resource_group.resource_group_name
    subnet_id     = module.networking.subnet_ids["snet-we-dev-integration-01"]
    vmsize        = var.vm_size
    adminuser     = var.admin_username
    adminpassword = var.admin_password
    image = {
      publisher = var.vm_image_publisher
      offer     = var.vm_image_offer
      sku       = var.vm_image_sku
    }
    tags = var.tags
  }

  mount_config = {
    mount_path      = "/mnt/${var.file_share_config.name}"
    file_share_name = module.storage.file_share_name
    storage_account = module.storage.storage_account_name
    account_key     = module.storage.file_share_mount_info.account_key
  }

  backend_pool_id = module.loadbalancer.backend_pool_identifier
}
