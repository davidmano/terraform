resource "azurerm_lb" "main" {
  name                = var.lbname
  location            = var.location
  resource_group_name = var.rgname
  sku = var.sku

  frontend_ip_configuration {
    name                 = "privateip-${var.lbname}"
    subnet_id = var.subnet_id
    private_ip_address_allocation =var.private_ip_address_allocation
    private_ip_address = var.private_ip_address
  }
tags = var.tags
}

resource "azurerm_lb_backend_address_pool" "main" {
  loadbalancer_id = azurerm_lb.main.id
  name            = "bp-${var.lbname}"
}

 resource "azurerm_network_interface_backend_address_pool_association" "vm1" {
      network_interface_id    = var.network_interface_id_1
      ip_configuration_name   = var.ip_configuration_name_1
      backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
    }

resource "azurerm_network_interface_backend_address_pool_association" "vm2" {
      network_interface_id    = var.network_interface_id_2
      ip_configuration_name   = var.ip_configuration_name_2
      backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
    }

resource "azurerm_lb_probe" "main" {
  loadbalancer_id = azurerm_lb.main.id
  resource_group_name = var.rgname
  name            = "hp-${var.lbname}"
  port            = var.port
}

 resource "azurerm_lb_rule" "main" {
  loadbalancer_id                = azurerm_lb.main.id
  resource_group_name = var.rgname
  name                           = "lbr-${var.lbname}"
  protocol                       = var.protocol
  frontend_port                  = var.frontend_port
  backend_port                   = var.backend_port
  frontend_ip_configuration_name = "privateip-${var.lbname}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
  probe_id = azurerm_lb_probe.main.id
 }