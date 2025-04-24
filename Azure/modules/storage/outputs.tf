output "file_share_mount_info" {
  value = {
    mount_path      = "/mnt/${azurerm_storage_share.fileshare.name}"
    file_share_name = azurerm_storage_share.fileshare.name
    storage_account = azurerm_storage_account.main.name
    account_key     = azurerm_storage_account.main.primary_access_key
  }
  sensitive = true
}