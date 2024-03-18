provider "azurerm" {
    features {}
}

resource "azurerm_resource_group" "example" {
    name     = "example-resources"
    location = "West Europe"
}

resource "azurerm_virtual_network" "example" {
    name                = "example-network"
    resource_group_name = azurerm_resource_group.example.name
    location            = azurerm_resource_group.example.location
    address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "example" {
    name                 = "example-subnet"
    resource_group_name  = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_kubernetes_cluster" "example" {
    name                = "example-aks"
    location            = azurerm_resource_group.example.location
    resource_group_name = azurerm_resource_group.example.name
    dns_prefix          = "exampleaks"

    default_node_pool {
        name       = "default"
        node_count = 1
        vm_size    = "Standard_B2s"
        vnet_subnet_id = azurerm_subnet.example.id
    }

    identity {
        type = "SystemAssigned"
    }

    tags = {
        Environment = "Production"
    }
}
