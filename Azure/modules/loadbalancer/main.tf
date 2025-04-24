resource "azurerm_public_ip" "main" {
  name                = "PublicIPForLB"
  location            = var.lb_config.location
  sku                 = "Standard"
  resource_group_name = var.lb_config.rgname
  allocation_method   = "Static"

  tags = var.lb_config.tags
}

resource "azurerm_lb" "main" {
  name                = var.lb_config.lbname
  location            = var.lb_config.location
  resource_group_name = var.lb_config.rgname
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.main.id
  }

  tags = var.lb_config.tags
}

resource "azurerm_lb_backend_address_pool" "main" {
  name                = var.lb_config.backend_pool_name
  loadbalancer_id     = azurerm_lb.main.id
}

resource "azurerm_lb_probe" "main" {
  name                = "http-probe"
  loadbalancer_id     = azurerm_lb.main.id
  protocol            = "Http"
  port                = var.lb_config.backend_port
  request_path        = var.lb_config.probe_path
}

resource "azurerm_lb_rule" "main" {
  name                           = "HTTPRule"
  loadbalancer_id                = azurerm_lb.main.id
  protocol                       = "Tcp"
  frontend_port                  = var.lb_config.frontend_port
  backend_port                   = var.lb_config.backend_port
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.main.id
}
