
resource "azurerm_public_ip" "main" {
    count = var.enable_publicip ? 1 : 0 #cambiado1
    name                = "${var.name}-publicip"
    resource_group_name = var.rgname
    location            = var.location
    allocation_method   = "Dynamic"
    tags = var.tags
}

#count.index









resource "azurerm_network_interface" "main" {
    name                = "${var.name}-ni2"
    location            = var.location
    resource_group_name = "Personal"

 dynamic ip_configuration {

for_each = var.enable_publicip ? [] : [1]

content {

    name                          = "${var.name}-privateip"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

}

dynamic ip_configuration {


for_each = var.enable_publicip ? [1] : []

content {


    name                          = "${var.name}-publicip"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.main[0].id #cambiado1
    #public_ip_address_id = azurerm_public_ip.main.id cambiado1
  }
}

  tags = var.tags
}




#resource "azurerm_network_interface" "publicip" {
 #   count = var.enable_publicip ? 1 : 0
  #  name                = "${var.name}-ni3"
   # location            = "westeurope"
    #resource_group_name = "Personal"

 # ip_configuration {
  #  name                          = "${var.name}-publicip"
   # subnet_id                     = var.subnet_id
   # private_ip_address_allocation = "Dynamic"
   # public_ip_address_id = azurerm_public_ip.main[0].id #cambiado1
   # #public_ip_address_id = azurerm_public_ip.main.id cambiado1
  #}
  #tags = var.tags
#}



#resource "azurerm_network_interface" "privateip" {
#    count = var.enable_publicip ? 0 : 1
#  name                = "${var.name}-privateni"
#  location            = var.location
#  resource_group_name = "Personal"
#
#  ip_configuration {
#    name                          = "${var.name}-privateip"
#    subnet_id                     = var.subnet_id
#    private_ip_address_allocation = "Dynamic"
#  }
#
#  tags = var.tags
#}

resource "azurerm_virtual_machine" "main" {
  
    name = var.name
    location = var.location
    resource_group_name   = var.rgname
    network_interface_ids = [
    azurerm_network_interface.main.id
  ]
    vm_size = var.vm_size
   # availability_set_id = var.availability_set

  # Uncomment this line to delete the OS disk automatically when deleting the VM
   delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
   delete_data_disks_on_termination = true

# az vm image list --output table --all >> ImagesVM.txt
#az vm image list-publishers --location francecentral >> Publishers.txt
# az vm image list-offers -l francecentral -p Oracle
# Get-AzVMImageSku -Location "francecentral" -PublisherName "Oracle" -Offer "Oracle-Linux"


  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = var.vm_version
  }
  storage_os_disk {
    name              = "${var.name}-OsDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = var.name
    admin_username = "fujitsu"
    admin_password = "Amparo.12345678"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  #boot_diagnostics {
  #  enabled = true
  #  storage_uri = "https://${var.storage_uri}.blob.core.windows.net"
    #storage_uri = "https://${var.storage_account.name}.blob.core.windows.net"
  #}
 tags = var.tags
}


#for_each = var.enable_backup ? [1] : []

#resource "azurerm_backup_protected_vm" "main" {
  
 # count = var.enable_backup ? 1 : 0

  #resource_group_name = var.rgname
  #recovery_vault_name = var.recovery_services_vault_name
  #source_vm_id        = azurerm_virtual_machine.main.id
  #backup_policy_id    = var.backup_policy_id

#}




#resource "azurerm_virtual_machine_extension" "MDELinux" {
#  name                 = "MDELinux"
#  virtual_machine_id   = azurerm_virtual_machine.main.id
#  publisher            = "Microsoft.Azure.AzureDefenderForServers.MDE.Linux"
#  type                 = "MDE.Linux"
#  type_handler_version = "1.0.0.36" #1.14.9 1.12
#}


#resource "azurerm_virtual_machine_extension" "OmsAgentForLinux" {
 # name                 = "OmsAgentForLinux"
 # virtual_machine_id   = azurerm_virtual_machine.main.id
 # publisher            = "Microsoft.EnterpriseCloud.Monitoring"
 # type                 = "OmsAgentForLinux"
 # type_handler_version = "1.14.11" #1.14.9 1.12
 # auto_upgrade_minor_version = true

  #settings = <<SETTINGS
   #   {
    #      "workspaceId": "c29db810-cce9-4b9b-8af6-386d4f236571"
     # }
  #SETTINGS

  #protected_settings = <<PROTECTEDSETTINGS
   #   {
    #      "workspaceKey":  "tT9uNnN/ovpD85OU0bjjFa8gtEJmAsoPOpV8MPW7vWYabn/VUn4EqBnZSXn9aTKHh/V870+wl+MXlDqTqLLDGQ=="
     # }
  #PROTECTEDSETTINGS
#}





resource "azurerm_virtual_machine_extension" "main" {
  name                 = "BIND-DNS-EUIPO-Extension"
  virtual_machine_id   = azurerm_virtual_machine.main.id
  # publisher            = "Microsoft.OSTCExtensions"
  # type                 = "CustomScriptForLinux"
  # type_handler_version = "1.2"
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"
  #auto_upgrade_minor_version = true

 # settings = <<SETTINGS
 #   {
 #       "commandToExecute": "sudo yum install bind-libs bind bind-utils -y"
 #   }
#SETTINGS

#  settings = <<SETTINGS
#   {
#   "fileUris": ["https://sahubsharedfrc001.blob.core.windows.net/scripts/dns_script.sh"],
#    "commandToExecute": "sh dns_script.sh"
 # }
#   SETTINGS

  settings = <<SETTINGS
   {
   "fileUris": ["${var.sh_file}"],
    "commandToExecute": "sh dns_script.sh"
  }
   SETTINGS




}


#resource "null_resource" "copy-test-file" {
#  connection {
#    type     = "ssh"
#    host     = azurerm_public_ip.main[0].ip_address
#    user     = "fujitsu"
#    password = "Amparo.12345678"
#  }

#  provisioner "file" {
#    source      = "named.conf"
#    destination = "/etc/named.conf"
#  }

#}

# https://stackoverflow.com/questions/48336058/running-a-custom-shell-script-in-azure-vm-using-terraform