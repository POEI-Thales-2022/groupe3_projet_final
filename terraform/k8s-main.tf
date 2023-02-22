resource "azurerm_public_ip" "k8s_main_ip" {
  name                = "k8s-main-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "k8s_main_nic" {
  name                = "k8s-main-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.k8s_main_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "k8s_main_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.k8s_main_nic.id
  network_security_group_id = azurerm_network_security_group.k8s_nsg.id
}

resource "azurerm_linux_virtual_machine" "k8s_main" {
  name                = "k8s-main"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B4ms"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.k8s_main_nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/projetfinal.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
