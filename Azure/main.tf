terraform {
  backend "azurerm" {
    resource_group_name  = "rg-we-dev-backend-01"
    storage_account_name = "stdevbackend01"
    container_name       = "stdevblob01"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  alias   = "data"
  features {}
  storage_use_azuread = false
}


provider "azurerm" {
  features {}
}

module "rg" {
  source   = "./modules/rg"
  region   = var.region
  rg_name  = var.rg_name
}

module "network" {
  source      = "./modules/network"
  vnet_name   = var.vnet_name
  address_space = var.address_space
  region      = var.region
  rg_name     = module.rg.rg_name
  tags        = var.tags
  subnets     = var.subnets

  depends_on = [ module.rg ]
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  lb_config = {
    location           = var.region
    rgname             = module.rg.rg_name
    lbname             = var.lb_name
    tags               = var.tags
    backend_pool_name  = var.backend_pool_name
    frontend_port      = var.frontend_port
    backend_port       = var.backend_port
    probe_path         = var.probe_path
  }

  depends_on = [ module.network ]
}

module "storage" {
  source              = "./modules/storage"
  providers = {
    azurerm.data = azurerm.data
  }

  region              = var.region
  resource_group_name = module.rg.rg_name

  storage_config = {
    prefix           = "stdev"
    account_tier     = "Standard"
    replication_type = "LRS"
    tags             = var.tags
  }

  file_share_config = {
    name  = "appshare"
    quota = 100
  }

  depends_on = [ module.loadbalancer ]
}

module "compute" {
  source = "./modules/compute"

  config = {
    vmname        = var.vm_name
    location      = var.region
    rgname        = module.rg.rg_name
    subnet_id     = module.network.subnet_ids["snet-we-dev-integration-01"]
    vmsize        = var.vm_size
    adminuser     = var.admin_username
    adminpassword = var.admin_password
    image = {
      publisher   = var.vm_image_publisher
      offer       = var.vm_image_offer
      sku         = var.vm_image_sku
    }
    tags          = var.tags
  }

  mount_config = {
    mount_path      = module.storage.file_share_mount_info.mount_path
    file_share_name = module.storage.file_share_mount_info.file_share_name
    storage_account = module.storage.file_share_mount_info.storage_account
    account_key     = module.storage.file_share_mount_info.account_key
  }

  backend_pool_id = module.loadbalancer.backend_pool_id

  depends_on = [ module.storage ]
}
