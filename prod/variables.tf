/* Configure Azure Provider and declare all the Variables that will be used in Terraform configurations */
provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  version         = ">= 2.0"
  features {}
}

####################
# COMMON VARIABLES #
####################

variable "subscription_id" {
  description = "Enter Subscription ID for provisioning resources in Azure"
}

variable "client_id" {
  description = "Enter Client ID for Application created in Azure AD"
}

variable "client_secret" {
  description = "Enter Client secret for Application in Azure AD"
}

variable "tenant_id" {
  description = "Enter Tenant ID / Directory ID of your Azure AD. Run Get-AzureSubscription to know your Tenant ID"
}

variable "buildby" {
  description = "Name of the builder."
  default     = "Daniel Manrique"
}

variable "buildticket" {
  description = "Ticket Number for the build"
  default     = "03092020-6960"
}

variable "environment" {
  description = "Prod,QA,STG,DEV,etc."
  default     = "PRD"
}

variable "location" {
  description = "Azure region for the environment."
  default     = "East US 2"
}

###################
# RESOURCE GROUPS #
###################

variable "app_rsg_name" {
  description = "Name of the app azure resource group."
  default     = "EU2-PRD-APP"
}

variable "db_rsg_name" {
  description = "Name of the database azure resource group."
  default     = "EU2-PRD-DB"
}

variable "con_rsg_name" {
  description = "Name of the ContPaq azure resource group."
  default     = "EU2-PRD-CON"
}

variable "vnet_rsg_name" {
  description = "Name of the VNET azure resource group."
  default     = "EU2-PRD-VNET"
}

variable "mgmt_rsg_name" {
  description = "Name of the MGMT azure resource group."
  default     = "EU2-PRD-MGMT"
}


####################
# VIRTUAL NETWORKS #
####################

variable "vnet_name" {
  description = "name for the vnet."
  default     = "EU2-VNET01"
}

variable "vnet_address_space" {
  description = "address range for vnet."
  default     = ["172.16.194.0/24"]
}

###########
# SUBNETS #
###########

variable "app_subnet_name" {
  description = "Name of the app subnet"
  default     = "EU2-VNET01-PRD-APP"
}

variable "app_subnet_range" {
  description = "IP range for app subnet"
  default     = "172.16.194.32/28"
}

variable "db_subnet_name" {
  description = "Name of the database subnet"
  default     = "EU2-VNET01-PRD-DB"
}

variable "db_subnet_range" {
  description = "IP range for database subnet"
  default     = "172.16.194.16/28"
}

variable "con_subnet_name" {
  description = "Name of the inside subnet"
  default     = "EU2-VNET01-PRD-CON"
}

variable "con_subnet_range" {
  description = "IP range for contpaq subnet"
  default     = "172.16.194.0/28"
}

#####################
# VM Common Details #
#####################


variable "admin_password" {
  description = "password for all VMs"
  default = "R@ckspace1029"
}

variable "vm_size" {
  description = "Size of the VM you want to create"
  default     = "Standard_B2ms"
}

variable "vm_timezone" {
  description = "Timezone to set the OS to using Microsoft Tiemzone Index values. See https://support.microsoft.com/en-gb/help/973627/microsoft-time-zone-index-values for values (2nd column)."
  default     = "UTC"
}

###############
# VMs Details #
###############

variable "vm_db_name" {
  description = "name for the VM"
  default     = "eu2psql01"
}

variable "vm_db_avset" {
  description = "Name of the Availability Set to create"
  default     = "EU2-PRD-BD-VM-AS"
}

variable "vm_db_disk_sku" {
  description = "Type of disk to use. Either Standard_LRS or Premium_LRS."
  default     = "Premium_LRS"
}



variable "vm_app_name" {
  description = "name for the VM"
  default     = "eu2papp01"
}

variable "vm_app_avset" {
  description = "Name of the Availability Set to create"
  default     = "EU2-PRD-APP-VM-AS"
}

variable "vm_app_disk_sku" {
  description = "Type of disk to use. Either Standard_LRS or Premium_LRS."
  default     = "Standard_LRS"
}




variable "vm_con_name" {
  description = "name for the VM"
  default     = "eu2psql02"
}


variable "vm_con_avset" {
  description = "Name of the Availability Set to create"
  default     = "EU2-PRD-CON-VM-AS"
}

variable "vm_con_disk_sku" {
  description = "Type of disk to use. Either Standard_LRS or Premium_LRS."
  default     = "Premium_LRS"
}



