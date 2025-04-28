output "network_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.network.id
}

output "subnet_ids" {
  description = "The IDs of the Subnets"
  value = {
    for subnet_name, subnet in azurerm_subnet.subnet : subnet_name => subnet.id
  }
}
