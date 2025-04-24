output "subnet_ids" {
  value = { for k, subnet in azurerm_subnet.subnets : k => subnet.id }
}