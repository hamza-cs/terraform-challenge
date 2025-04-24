variable "lb_config" {
  description = "Load Balancer configuration"
  type = object({
    location           = any
    rgname             = any
    lbname             = string
    tags               = map(string)
    backend_pool_name  = string
    frontend_port      = number
    backend_port       = number
    probe_path         = string
  })
}
