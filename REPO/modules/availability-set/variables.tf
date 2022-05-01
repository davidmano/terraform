variable "name" {
    type = string
    description = "Name of storage account"
}
variable "rgname" {
    type = string
    description = "Name of resource group"
}
variable "location" {
    type = string
    description = "Azure location of as environment"
    default = "westeurope"
}
variable "tags" {
    type = object({Cloud = string, Department = string, Owner = string, Environment = string, Service = string, CostCenter = string, SupportTeam = string, MaintenanceWindows = string, CreationDate = string, ExpirationDate = string, BackupEnabled = string, SLA = string})
    description = "Azure location of storage account environment"
}