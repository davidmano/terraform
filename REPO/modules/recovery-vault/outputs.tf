output "recovery_services_vault_name" {
  description = "Name of the Recovery Vault"
  value       = azurerm_recovery_services_vault.main.name
}
output "backup_policy_id" {
  description = "Id of the backup policy of the Recovery Vault"
  value       = azurerm_backup_policy_vm.dns.id
}