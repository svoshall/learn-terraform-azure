resource "azurerm_resource_group" "rg_current" {
  name     = "rg-fond-snail"
  location = var.resource_group_location
}

resource "azurerm_container_group" "container" {
  name                = "acigroup-fns13lbb2ir3wz5xcvg9ikl66"
  location            = azurerm_resource_group.rg_current.location
  resource_group_name = azurerm_resource_group.rg_current.name
  ip_address_type     = "Public"
  os_type             = "Linux"
  restart_policy      = var.restart_policy
  container {
    name   = "aci-fns13lbb2ir3wz5xcvg9ikl66"
    image  = var.image
    cpu    = var.cpu_cores
    memory = var.memory_in_gb

    ports {
      port     = var.port
      protocol = "TCP"
    }
  }
}

resource "azurerm_resource_group" "rg_registry_current" {
  name     = "myResourceGroup"
  location = var.resource_group_location
}

resource "azurerm_container_registry" "acr" {
  name                = "sammydemoregistry"
  resource_group_name = azurerm_resource_group.rg_registry_current.name
  location            = azurerm_resource_group.rg_registry_current.location
  sku                 = "Premium"
  admin_enabled       = false
  georeplications {
    location                = "East US2"
    zone_redundancy_enabled = true
    tags                    = {}
  }
  georeplications {
    location                = "North Europe"
    zone_redundancy_enabled = true
    tags                    = {}
  }
}