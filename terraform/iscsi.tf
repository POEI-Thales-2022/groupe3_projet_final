resource "azurerm_public_ip" "iscsi_ip" {
  name                = "iscsi-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "iscsi_nsg" {
  name                = "iscsi-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "iSCSI-1"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "860"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "iSCSI-2"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3260"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

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
  network_security_group_id = azurerm_network_security_group.iscsi_nsg.id
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
  
 # resource "azurerm_managed_disk" "gitlab_config_disk" {
 # name                = "gitlab-config-disk"
 # location            = azurerm_resource_group.rg.location
 # resource_group_name = azurerm_resource_group.rg.name
 # storage_account_type = "Premium_LRS"
 # disk_size_gb = 50
  }

# resource "azurerm_managed_disk" "gitlab_log_disk" {
 # name                = "gitlab-log-disk"
 # location            = azurerm_resource_group.rg.location
 # resource_group_name = azurerm_resource_group.rg.name
 # storage_account_type = "Premium_LRS"
 # disk_size_gb = 50
  }

# resource "azurerm_managed_disk" "gitlab_data_disk" {
 # name                = "gitlab-data-disk"
 # location            = azurerm_resource_group.rg.location
 # resource_group_name = azurerm_resource_group.rg.name
 # storage_account_type = "Premium_LRS"
 # disk_size_gb = 50
  }
}
