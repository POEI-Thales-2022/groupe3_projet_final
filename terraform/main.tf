resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  resource_group_name = random_pet.rg_name.id
  location            = var.resource_group_location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = random_pet.rg_name.id
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

#creation vm
resource "azurerm_linux_virtual_machine" "gitlab" {
  name                = "gitlab"
  resource_group_name = random_pet.rg_name.id
  location            = var.resource_group_location
  size                = "Standard_B4msv2"
  admin_username      = "adminuser"

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/projetfinal.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "22.04-LTS"
    version   = "latest"
  }
}
