resource "azurerm_storage_account" "main" {
  name                     = var.saname
  resource_group_name      = var.rgname
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true
}
resource "azurerm_storage_container" "scripts" {
  depends_on = [azurerm_storage_account.main]
  name                  = var.blobname
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "container"
  #Possible values are blob, container or private. Defaults to private
  # https://www.reddit.com/r/Terraform/comments/kieou4/making_azure_storage_blob_public/
}