variable "name" {
    type = string
    description = "Name of the Log Analytics Workspace"
}
variable "rgname" {
    type = string
    description = "Name of the resource group of the Log Analytics Workspace"
}
variable "location" {
    type = string
    description = "Azure location of the Log Analytics Workspace"
}
variable "sku" {
    type = string
    description = "SKU of the Log Analytics Workspace"
    deafult  ="PerGB2018"
    # Possible values = Free, PerNode, Premium, Standard, Standalone, Unlimited, CapacityReservation and PerGB2018
}
variable "retention_in_days" {
    type = number
    description = "Retention in days of the Log Analytics Workspace"
    # Possible values are either 7 (Free Tier only) or range between 30 and 730
}