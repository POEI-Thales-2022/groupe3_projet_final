resource "azurerm_network_interface" "iscsi_nic" {
  name                = "iscsi-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.iscsi_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "iscsi_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.iscsi_nic.id
  network_security_group_id = azurerm_network_security_group.default_nsg.id
}

resource "azurerm_linux_virtual_machine" "iscsi" {
  name                = "iscsi"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.iscsi_nic.id,
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
