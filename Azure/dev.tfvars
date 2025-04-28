# General
region   = "westeurope"
rg_name  = "rg-we-dev-platform-01"
subscription_id = "7a9edfb7-adcb-438b-b187-7be822f7841b"
tenant_id       = "026e0585-0f6d-4eb2-ba93-8c4a4d4883c4"

tags = {
  env    = "dev"
  system = "platform"
}

# Network
vnet_name     = "vnet-we-dev-platform-01"
address_space = ["10.1.0.0/16"]

subnets = {
  "snet-we-dev-pep-01" = {
    address_prefixes = ["10.1.1.0/24"]
  },
  "snet-we-dev-integration-01" = {
    address_prefixes = ["10.1.2.0/24"]
  }
}

# Load Balancer
lb_name           = "lb-we-dev-platform-01"
backend_pool_name = "backendpool-we-dev"
frontend_port     = 80
backend_port      = 80
probe_path        = "/health"

# Storage
storage_prefix   = "stdev"
account_tier     = "Standard"
replication_type = "LRS"

file_share_config = {
  name  = "appshare"
  quota = 50
}

# Compute
vm_name          = "vmss-we-dev-platform-01"
vm_size          = "Standard_B2ms"
admin_username   = "azureuser"
admin_password   = "ChangeM3Plz@123" # (IMPORTANT: secure this!)
vm_image_publisher = "Canonical"
vm_image_offer     = "UbuntuServer"
vm_image_sku       = "18.04-LTS"
