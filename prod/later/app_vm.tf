#Code to build out complete VM.
# See https://www.terraform.io/docs/providers/azurerm/r/virtual_machine.html fro syntax.

#boot diag storage account
resource "random_id" "randomId" {
  byte_length = 8
}

resource "azurerm_storage_account" "vmdiagsa" {
  name                     = "${random_id.randomId.hex}diagsa"
  resource_group_name      = azurerm_resource_group.mgmt_rsg.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

# availabilty set
resource "azurerm_availability_set" "eu2_prd_app_vm_avset" {
  name                = var.vm_avset
  location            = var.location
  resource_group_name = azurerm_resource_group.app_rsg.name
  managed             = true

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

# NIC
resource "azurerm_network_interface" "eu2_prd_app_vm_nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.app_rsg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.app.id
    private_ip_address_allocation = "dynamic"
  }

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

#VM
resource "azurerm_virtual_machine" "eu2_prd_app_vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = azurerm_resource_group.app_rsg.name
  network_interface_ids = [azurerm_network_interface.eu2_prd_app_vm_nic.id]
  availability_set_id   = azurerm_availability_set.eu2_prd_app_vm_avset.id
  vm_size               = var.vm_size

  # Uncomment the line below to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment the line below to delete the data disks automatically when deleting the VM
  #delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = var.vm_disk_sku
  }
  os_profile {
    computer_name  = var.vm_name
    admin_username = "${lower(var.vm_name)}-adm"
    admin_password = var.admin_password
  }
  os_profile_windows_config {
    provision_vm_agent = true
    timezone           = var.vm_timezone
  }
  storage_data_disk {
    name              = "${var.vm_name}-disk1"
    create_option     = "Empty"
    caching           = "None"
    managed_disk_type = var.vm_disk_sku
    disk_size_gb      = 128
    lun               = 0
  }
  storage_data_disk {
    name              = "${var.vm_name}-disk2"
    create_option     = "Empty"
    caching           = "None"
    managed_disk_type = var.vm_disk_sku
    disk_size_gb      = 128
    lun               = 1
  }
  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.vmdiagsa.primary_blob_endpoint
  }
  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

output "eu2_prd_app_vm_name" {
  value = azurerm_virtual_machine.eu2_prd_app_vm.name
}

output "eu2_prd_app_vm_username" {
  value = "${lower(var.vm_name)}-adm"
}

output "eu2_prd_app_vm_password" {
  value = var.admin_password
}

output "eu2_prd_app_vm_private_ips" {
  value = azurerm_network_interface.eu2_prd_app_vm_nic.private_ip_address
}

output "eu2_prd_app_vm_rsg" {
  value = azurerm_virtual_machine.eu2_prd_app_vm.resource_group_name
}

output "eu2_prd_app_vm_location" {
  value = azurerm_virtual_machine.eu2_prd_app_vm.location
}

