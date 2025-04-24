output "public_ip" {
  description = "The public IP address of the load balancer"
  value       = azurerm_public_ip.main.ip_address
}

output "backend_pool_id" {
  value = azurerm_lb_backend_address_pool.main.id
}
