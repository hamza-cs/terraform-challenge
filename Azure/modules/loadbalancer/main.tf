resource "azurerm_public_ip" "load_balancer_ip" {
  name                = "LBPublicIP"
  location            = var.lb_settings.location
  sku                 = "Standard"
  resource_group_name = var.lb_settings.resource_group
  allocation_method   = "Static"

  tags = var.lb_settings.tags
}

resource "azurerm_lb" "load_balancer" {
  name                = var.lb_settings.load_balancer_name
  location            = var.lb_settings.location
  resource_group_name = var.lb_settings.resource_group
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "FrontendIP"
    public_ip_address_id = azurerm_public_ip.load_balancer_ip.id
  }

  tags = var.lb_settings.tags
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name                = var.lb_settings.backend_pool_name
  loadbalancer_id     = azurerm_lb.load_balancer.id
}

resource "azurerm_lb_probe" "health_probe" {
  name                = "HealthProbe"
  loadbalancer_id     = azurerm_lb.load_balancer.id
  protocol            = "Http"
  port                = var.lb_settings.backend_port
  request_path        = var.lb_settings.probe_path
}

resource "azurerm_lb_rule" "load_balancer_rule" {
  name                           = "HttpLoadBalancerRule"
  loadbalancer_id                = azurerm_lb.load_balancer.id
  protocol                       = "Tcp"
  frontend_port                  = var.lb_settings.frontend_port
  backend_port                   = var.lb_settings.backend_port
  frontend_ip_configuration_name = "FrontendIP"
  probe_id                       = azurerm_lb_probe.health_probe.id
}
