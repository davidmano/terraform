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
  common_tags = {
   Cloud        = "server-interface"
   Environment     = "Terraform-Deploy"
  }
}

#resource "azurerm_resource_group" "rg" {
 # name     = var.resource_group_name
  #location = "westeurope"
#}

module "naming" {
  source  = "./REPO/modules/naming"
  suffix = [ "suffix" ]
  prefix = [ "prefix" ]
}


#resource "azurerm_resource_group" "rg" {
#  name     = module.naming.resource_group.name
#  location = "West Europe"
# 3}

#condition ? true_val : false_val
# var.a != "" ? var.a : "default-a"


# var.namedd != "" ? var.name == "dfdfd": var.name == "default-a"

# Create Virtual Machine
module "virtual-machine" {
  source  = "./REPO/modules/virtual-machine"
  name = "linuxvmrh"
  rgname = "Personal"
  subnet_id = "/subscriptions/b5d78098-fdad-47e1-b1ee-ecaab2031eb1/resourceGroups/Personal/providers/Microsoft.Network/virtualNetworks/Personal-vnet/subnets/default"
  location = "westeurope"
  enable_publicip = true
tags = local.common_tags
}

#Create Storage Account
module "storage_account" {
  source    = "./REPO/modules/storage-account"
  saname    = "statfdemosa2x2x1"
  rgname    = "Personal" # azurerm_resource_group.rg.name
  location  = "westeurope"
  enable_publicip = true
}