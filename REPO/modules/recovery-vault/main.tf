resource "azurerm_recovery_services_vault" "main" {
  name                = var.name
  location            = var.location
  resource_group_name = var.rgname
  sku                 = "Standard"
  soft_delete_enabled = false
  tags = var.tags
}

resource "azurerm_backup_policy_vm" "dns" {
  name                = "dns-vm-recovery-vault-policy"
  resource_group_name = var.rgname
  recovery_vault_name = azurerm_recovery_services_vault.main.name
  timezone = "UTC"

  backup {
    frequency = "Daily"
    time      = "23:00"
  }

  retention_daily {
    count = 10
  }

  retention_weekly {
    count    = 42
    weekdays = ["Sunday", "Wednesday", "Friday", "Saturday"]
  }

  retention_monthly {
    count    = 7
    weekdays = ["Sunday", "Wednesday"]
    weeks    = ["First", "Last"]
  }

  retention_yearly {
    count    = 77
    weekdays = ["Sunday"]
    weeks    = ["Last"]
    months   = ["January"]
  }
}