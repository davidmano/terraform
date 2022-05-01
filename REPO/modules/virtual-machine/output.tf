#output "network_interface_private_ip" {
#  description = "private ip addresses of the vm nics"
#  value       = azurerm_network_interface.vm.main.private_ip_address
#}
#output "network_interface_ids" {
#  description = "ids of the vm nics provisoned."
#  value       = azurerm_network_interface.vm.main.id
#}
output "network_interface_ids" {
  description = "ids of the vm nics provisoned."
  value       = azurerm_network_interface.main.id
}
output "ip_configuration_name" {
  description = "name of the ip configuration of the vm nics provisoned."
  value       = azurerm_network_interface.main.ip_configuration[0].name
}