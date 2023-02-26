resource "azurerm_network_interface" "k8s_worker_nic" {
  name                = "k8s-worker-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "k8s_worker_nsg_assoc" {
  network_interface_id      = azurerm_network_interface.k8s_worker_nic.id
  network_security_group_id = azurerm_network_security_group.default_nsg.id
}

resource "azurerm_linux_virtual_machine" "k8s_worker" {
  name                = "k8s-worker"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = "Standard_B2ms"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.k8s_worker_nic.id,
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
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }
}
