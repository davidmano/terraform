output "load_balancer" {
  description = "Output data of the Load Balancer"
  value       = local.az.load_balancer
}
output "storage_account" {
  description = "Output data of the Storage Account"
  value       = local.az.storage_account
}
output "recovery_services_vault" {
  description = "Output data of the Recovey Services Vault"
  value       = local.az.recovery_services_vault
}