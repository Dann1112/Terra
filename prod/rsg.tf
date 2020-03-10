# Code for Resource Groups begins here.
# See https://www.terraform.io/docs/providers/azurerm/r/resource_group.html for syntax

resource "azurerm_resource_group" "app_rsg" {
  name     = var.app_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "db_rsg" {
  name     = var.db_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "con_rsg" {
  name     = var.con_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "vnet_rsg" {
  name     = var.vnet_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}

resource "azurerm_resource_group" "mgmt_rsg" {
  name     = var.mgmt_rsg_name
  location = var.location

  tags = {
    Environment = var.environment
    BuildBy     = var.buildby
    BuildTicket = var.buildticket
    BuildDate   = replace(substr(timestamp(), 0, 10), "-", "")
  }
}
