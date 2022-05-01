# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}


locals {
  # Common tags to be assigned to all resources
  location = "westeurope"
  resource_group = "Personal"
common_tags = {
  Cloud="Azure"
  Department="Networking"
  Owner=""
  Environment="Production"
  Service=""
  CostCenter=""
  SupportTeam="Fujin"
  MaintenanceWindows="Yes"
  CreationDate="05/01/2022"
  ExpirationDate="Never"
  BackupEnabled=""
  SLA=""
  }
}


# Create Resource Group
#resource "azurerm_resource_group" "rg" {
# name     = local.resource_group
# location = local.location
#}

#module "naming" {
#  source  = "./REPO/modules/naming"
#  suffix = [ "suffix" ]
#  prefix = [ "prefix" ]
#}

module "nomenclature" {
  source  = "./REPO/modules/nomenclature"
  service = "hub"
  environment = "shared"
  region = "frc"
  instance = "001"
}



#Create Storage Account
module "storage_account" {
  source    = "./REPO/modules/storage-account"
  saname    = module.nomenclature.storage_account.name
  rgname    = local.resource_group
  location  = local.location
  enable_publicip = true
  blobname = "scripts"
}



#Upoload file to blob Storage Account
module "storage-blob" {
  source    = "./REPO/modules/storage-blob"
  saname = module.storage_account.storage_account_name
  blobname = module.storage_account.storage_account_blob_name

  #saname    = "/subscriptions/b5d78098-fdad-47e1-b1ee-ecaab2031eb1/resourceGroups/Personal/providers/microsoft.storage/storageAccounts/sahubsharedfrc001"
}

module "recovery-services-vault" {
  source  = "./REPO/modules/recovery-vault"
  name = module.nomenclature.recovery_services_vault.name
  rgname = local.resource_group
  location = local.location
  tags = local.common_tags
}

module "availability-set" {
  source  = "./REPO/modules/availability-set"
  name = "ashubdnsfrc001"
  rgname = local.resource_group
 location = local.location
tags = local.common_tags
}

# Create Virtual Machine
module "virtual-machine-1" {
  source  = "./REPO/modules/virtual-machine"
  name = "ofzlp-dns003"
  rgname = local.resource_group
  subnet_id = "/subscriptions/e2049371-6da5-422d-9e9c-f4d794f818ff/resourceGroups/rg-hub-shared-frc-001/providers/Microsoft.Network/virtualNetworks/vnet-hub-shared-frc-001/subnets/subnet_CS_HRZ_prod_fr-central_2112"
  location = local.location
  publisher = "Oracle"
  offer = "Oracle-Linux"
  sku = "ol85-lvm-gen2"
  vm_version = "latest"
  vm_size = "Standard_DS1_v2"
 # availability_set = module.availability-set.availability_set_id
 availability_set = "none"
  enable_publicip = false
  #sh_file = module.storage-blob.blob_public_address
  sh_file = "https://sarghubsharedfrc001.blob.core.windows.net/scripts/dns_script.sh"
  storage_uri = module.storage_account.storage_account_name
  enable_backup = false
  #recovery_services_vault_name = module.recovery-services-vault.recovery_services_vault_name
  #backup_policy_id = module.recovery-services-vault.backup_policy_id
  recovery_services_vault_name = "none"
  backup_policy_id = "none"
tags = local.common_tags
}

module "virtual-machine-2" {
  source  = "./REPO/modules/virtual-machine"
  name = "ofzlp-dns002"
  rgname = local.resource_group
  subnet_id = "/subscriptions/b5d78098-fdad-47e1-b1ee-ecaab2031eb1/resourceGroups/Personal/providers/Microsoft.Network/virtualNetworks/Personal-vnet/subnets/default"
  location = local.location
  publisher = "Oracle"
  offer     = "Oracle-Linux"
  sku       = "ol85-lvm-gen2"
  vm_version   = "latest"
  vm_size = "Standard_DS1_v2"
  availability_set = module.availability-set.availability_set_id
  enable_publicip = false
  sh_file = module.storage-blob.blob_public_address
  #sh_file = "https://sahubsharedfrc001.blob.core.windows.net/scripts/dns_script.sh"
  storage_uri = module.storage_account.storage_account_name
  enable_backup = false
  recovery_services_vault_name = module.recovery-services-vault.recovery_services_vault_name
  backup_policy_id = module.recovery-services-vault.backup_policy_id
tags = local.common_tags
}







module "load-balancer" {
  source    = "./REPO/modules/load-balancer"
  #lbname = "lb-hub-shared-frc-001"
  lbname = module.nomenclature.load_balancer.name
  rgname    = local.resource_group
  sku = "Basic"
  location  = local.location
  subnet_id = "/subscriptions/b5d78098-fdad-47e1-b1ee-ecaab2031eb1/resourceGroups/Personal/providers/Microsoft.Network/virtualNetworks/Personal-vnet/subnets/default"
  tags = local.common_tags
  # Frontend IP configuration
  private_ip_address = "10.1.0.20"
  private_ip_address_allocation = "Static"
  # Backend pools
  network_interface_id_1    = module.virtual-machine-1.network_interface_ids
  #network_interface_id    = "/subscriptions/b5d78098-fdad-47e1-b1ee-ecaab2031eb1/resourceGroups/Personal/providers/Microsoft.Network/networkInterfaces/davidmn350" 
  #ip_configuration_name   = "linuxvmrh-publicip"
  ip_configuration_name_1   = module.virtual-machine-1.ip_configuration_name
  network_interface_id_2    = module.virtual-machine-2.network_interface_ids
  ip_configuration_name_2   = module.virtual-machine-2.ip_configuration_name
  #"ipconfig1"
  # Health probes
  port = 3389
  # Load Balacing Rules
   protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
}