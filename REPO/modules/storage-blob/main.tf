resource "azurerm_storage_blob" "main" {
  name                   = "dns_script.sh"
  storage_account_name   = var.saname
  storage_container_name = var.blobname
  type                   = "Block"
  source                 = "./dns_script.sh"
}