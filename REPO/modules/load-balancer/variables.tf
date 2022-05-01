variable "lbname" {
    type = string
    description = "Name of the Load balancer"
}
variable "rgname" {
    type = string
    description = "Name of the Resource group"
}
variable "location" {
    type = string
    description = "Azure location of the Load Balancer"
}
variable "sku" {
    type = string
    description = "SKU of the Load Balancer"
    default = "Basic"
}
variable "subnet_id" {
    type = string
    description = "Id of the subnet of the Frontend´s IP address"
}
variable "private_ip_address" {
    type = string
    description = "Frontend´s IP addresst"
}
variable "private_ip_address_allocation" {
    type = string
    description = "Frontend´s IP address allocation"
    default = "Static"
}
variable "network_interface_id_1" {
    type = string
    description = "Id of the network interface of the Backend pool"
}
variable "ip_configuration_name_1" {
    type = string
    description = "Name of the IP configuration of the network interface of the Backend pool"
}
variable "network_interface_id_2" {
    type = string
    description = "Id of the network interface of the Backend pool"
}
variable "ip_configuration_name_2" {
    type = string
    description = "Name of the IP configuration of the network interface of the Backend pool"
}
variable "port" {
    type = number
    description = "Port of the Health Probe"
}
variable "protocol" {
    type = string
    description = "Protocol of the Load balancing rule"
    default = "Tcp"
}
variable "frontend_port" {
    type = number
    description = "Frontend port of the Load balancing rule"
}
variable "backend_port" {
    type = number
    description = "Backend port of the Load balancing rule"
}
variable "tags" {
    type = object({Cloud = string, Department = string, Owner = string, Environment = string, Service = string, CostCenter = string, SupportTeam = string, MaintenanceWindows = string, CreationDate = string, ExpirationDate = string, BackupEnabled = string, SLA = string})
    description = "Common tags in EUIPO Azure Cloud"
}