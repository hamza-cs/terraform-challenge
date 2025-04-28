resource "azurerm_virtual_network" "network" {
  name                = var.network_name
  address_space       = var.network_address_space
  location            = var.region
  resource_group_name = var.resource_group
  tags                = var.resource_tags
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnet_configs

  name                 = each.key
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.network.name
  address_prefixes     = each.value.address_prefixes
}
