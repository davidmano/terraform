resource "azurerm_availability_set" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rgname
tags = var.tags
}