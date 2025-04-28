output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.storage_account.name
}

output "storage_account_id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.storage_account.id
}

output "file_share_name" {
  description = "The name of the File Share"
  value       = azurerm_storage_share.file_share.name
}

output "file_share_id" {
  description = "The ID of the File Share"
  value       = azurerm_storage_share.file_share.id
}

output "file_share_mount_info" {
  description = "Information needed to mount the file share"
  value = {
    storage_account = azurerm_storage_account.storage_account.name
    file_share_name = azurerm_storage_share.file_share.name
    mount_path      = "/mnt/${azurerm_storage_share.file_share.name}"
    account_key     = azurerm_storage_account.storage_account.primary_access_key
  }
}
