variable "name" {
    type = string
    description = "Name of the Virtual Machine"
}
variable "rgname" {
    type = string
    description = "Name of resource group of the Virtual Machine"
}
variable "subnet_id" {
    type = string
    description = "Subnet of the Virtual Machine"
}
variable "publisher" {
    type = string
    description = "Publiher of the Virtual Machine"
}
variable "offer" {
    type = string
    description = "Offer of the Virtual Machine"
}
variable "sku" {
    type = string
    description = "SKU of the Virtual Machine"
}
variable "vm_version" {
    type = string
    description = "Version of the Virtual Machine"
}
variable "vm_size" {
    type = string
    description = "Size of the Virtual Machine"
}
variable "availability_set" {
    type = string
    description = "Availability Set of the Virtual Machine"
}
variable "location" {
    type = string
    description = "Azure location of the Virtual Machine"
}
variable "enable_publicip" {
    type = bool
    description = "Public IP of the Virtual Machine (true/false)"
    default = false
}
variable "enable_backup" {
    type = bool
    description = "Enable backup of the Virtual Machine (true/false)"
    default = false
}
variable "storage_uri" {
    type = string
    description = "Storage Account for Boor diagnostics of the Virtual Machine"
}
variable "recovery_services_vault_name" {
    type = string
    description = "Recovery Services Vault of the Virtual Machine"
}
variable "backup_policy_id" {
    type = string
    description = "Backup Policy of the Recovery Services Vault of the Virtual Machine"
}
variable "sh_file" {
    type = string
    description = "Sh of the Linux the Virtual Machine"
}
variable "tags" {
    type = object({Cloud = string, Department = string, Owner = string, Environment = string, Service = string, CostCenter = string, SupportTeam = string, MaintenanceWindows = string, CreationDate = string, ExpirationDate = string, BackupEnabled = string, SLA = string})
    description = "Tags of the Virtual Machine"
}