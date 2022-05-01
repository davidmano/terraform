output "blob_public_address" {
   value = "https://${azurerm_storage_blob.main.storage_account_name}.blob.core.windows.net/${azurerm_storage_blob.main.storage_container_name}/${azurerm_storage_blob.main.name}"
}