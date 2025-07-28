provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "${{ values.resource_group_name }}"
  location = "West Europe"

  tags = {
    for pair in split(",", "${{ values.resource_group_tags }}") : 
    trim(split(":", pair)[0]) => trim(split(":", pair)[1])
  }
}

resource "azurerm_storage_account" "main" {
  name                     = "${{ values.storage_account_name }}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "${{ values.sku }}"
  access_tier              = "${{ values.access_tier }}"

  tags = {
    for pair in split(",", "${{ values.storage_account_tags }}") : 
    trim(split(":", pair)[0]) => trim(split(":", pair)[1])
  }
}

resource "azurerm_storage_container" "main" {
  name                  = "${{ values.container_name }}"
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = "${{ values.container_type }}"
}
