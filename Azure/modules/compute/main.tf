resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                = var.config.vmname
  location            = var.config.location
  resource_group_name = var.config.rgname
  sku                 = var.config.vmsize
  instances           = 2
  admin_username      = var.config.adminuser
  admin_password      = var.config.adminpassword
  disable_password_authentication = false
  custom_data = base64encode(templatefile("${path.module}/mount-share.sh.tftpl", {
    mount_path      = var.mount_config.mount_path
    file_share_name = var.mount_config.file_share_name
    storage_account = var.mount_config.storage_account
    account_key     = var.mount_config.account_key
  }))

  source_image_reference {
    publisher = var.config.image.publisher
    offer     = var.config.image.offer
    sku       = var.config.image.sku
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  network_interface {
    name    = "vmss-nic"
    primary = true

    ip_configuration {
      name      = "vmss-ip"
      subnet_id = var.config.subnet_id
      primary   = true
      load_balancer_backend_address_pool_ids = [var.backend_pool_id]
    }
  }

  tags = var.config.tags
}

resource "azurerm_monitor_autoscale_setting" "vmss_autoscale" {
  name                = "autoscale-vmss"
  location            = var.config.location
  resource_group_name = var.config.rgname
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss.id

  profile {
    name = "default"

    capacity {
      minimum = "2"
      maximum = "5"
      default = "2"
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_namespace   = "Microsoft.Compute/virtualMachineScaleSets"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 70
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT2M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_namespace   = "Microsoft.Compute/virtualMachineScaleSets"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 30
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT2M"
      }
    }
  }
}
