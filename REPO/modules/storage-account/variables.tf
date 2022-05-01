variable "saname" {
    type = string
    description = "Name of the storage account"
}
variable "rgname" {
    type = string
    description = "Name of the resource group"
}
variable "location" {
    type = string
    description = "Azure location of storage account environment"
}
variable "enable_publicip" {
    type = bool
    description = "Azure location of storage account environment"
    default = false
}
variable "blobname" {
    type = string
    description = "Name of the blob of the storage account"
}