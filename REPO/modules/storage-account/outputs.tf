output "storage_account_name" {
  description = "Output data of the Storage Account"
  value       = azurerm_storage_account.main.name
}
output "storage_account_blob_name" {
  description = "Output data of the Storage Account"
  value       = azurerm_storage_container.scripts.name
}