resource "azurerm_log_analytics_workspace" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rgname
  sku                 = var.sku
  retention_in_days   = var.retention_in_days
}