output "load_balancer_id" {
  description = "The unique identifier of the Load Balancer"
  value       = azurerm_lb.load_balancer.id
}

output "backend_pool_identifier" {
  description = "The unique identifier of the Backend Address Pool"
  value       = azurerm_lb_backend_address_pool.backend_pool.id
}

output "public_ip_identifier" {
  description = "The unique identifier of the Public IP assigned to the Load Balancer"
  value       = azurerm_public_ip.load_balancer_ip.id
}

output "frontend_ip_configuration_details" {
  description = "Details of the Frontend IP configuration for the Load Balancer"
  value       = azurerm_lb.load_balancer.frontend_ip_configuration
}
