provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = "West Europe"
  tags = {
    ${replace(var.resource_group_tag, ":", " = ")}
  }
}

resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.storage_account_resource_group
  location                 = "West Europe"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier              = var.access_tier
  sku_name                 = var.sku

  tags = {
    ${replace(var.storage_account_tag, ":", " = ")}
  }
}

resource "azurerm_storage_container" "main" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = var.container_type
}
