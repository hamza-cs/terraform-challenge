output "vmss_id" {
  description = "The ID of the Virtual Machine Scale Set"
  value       = azurerm_linux_virtual_machine_scale_set.linux_vmss.id
}

output "vmss_name" {
  description = "The name of the Virtual Machine Scale Set"
  value       = azurerm_linux_virtual_machine_scale_set.linux_vmss.name
}

output "autoscale_setting_id" {
  description = "The ID of the VMSS Autoscale Setting"
  value       = azurerm_monitor_autoscale_setting.vmss_autoscaling.id
}
