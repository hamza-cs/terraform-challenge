variable "lb_settings" {
  description = "Configuration block for Load Balancer settings"
  type = object({
    location           = string
    resource_group     = string
    load_balancer_name = string
    tags               = map(string)
    backend_pool_name = string
    frontend_port      = number
    backend_port       = number
    probe_path         = string
  })
}
