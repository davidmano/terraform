variable "name" {
    type = string
    description = "Name of the Recovery Services vault"
}
variable "rgname" {
    type = string
    description = "Name of the resource group"
}
variable "location" {
    type = string
    description = "Azure location of the Recovery Services vault"
}
variable "tags" {
    type = object({Cloud = string, Department = string, Owner = string, Environment = string, Service = string, CostCenter = string, SupportTeam = string, MaintenanceWindows = string, CreationDate = string, ExpirationDate = string, BackupEnabled = string, SLA = string})
    description = "Azure location of storage account environment"
}