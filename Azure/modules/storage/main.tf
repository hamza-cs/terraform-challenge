resource "azurerm_storage_account" "storage_account" {
  name                          = lower("${var.storage_config.prefix}${random_string.suffix.result}")
  resource_group_name           = var.resource_group_name
  location                      = var.location
  account_tier                  = var.storage_config.account_tier
  account_replication_type      = var.storage_config.replication_type
  public_network_access_enabled = true

  tags = var.storage_config.tags
}

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_storage_share" "file_share" {
  name                 = var.file_share_config.name
  storage_account_name = azurerm_storage_account.storage_account.name
  quota                = var.file_share_config.quota
}
