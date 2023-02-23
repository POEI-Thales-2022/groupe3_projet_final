locals {
    location          = "weastus3"
    prefix            = "vpn"
}


resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "mgmt" {
    name                 = "mgmt"
    resource_group_name  = azurerm_resource_group.rg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "vpnpip" {
    name                = "${local.prefix}-pip"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "vpn-nic" {
    name                 = "${local.prefix}-nic"
    location             = azurerm_resource_group.rg.location
    resource_group_name  = azurerm_resource_group.rg.name
    enable_ip_forwarding = true

    ip_configuration {
    name                          = local.prefix
    subnet_id                     = azurerm_subnet.mgmt.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.vpn-pip.id
    }
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "vpn-nsg" {
    name                = "${local.prefix}-nsg"
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
}

resource "azurerm_subnet_network_security_group_association" "mgmt-nsg-association" {
    subnet_id                 = azurerm_subnet.mgmt.id
    network_security_group_id = azurerm_network_security_group.vpn-nsg.id
}

resource "azurerm_virtual_machine" "vpn-vm" {
    name                  = "${local.prefix}-vm"
    location              = azurerm_resource_group.rg.location
    resource_group_name   = azurerm_resource_group.rg.name
    network_interface_ids = [azurerm_network_interface.vpn-nic.id]
    vm_size               = var.vmsize

    storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
    }

    storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    }

    os_profile {
    computer_name  = "${local.prefix}-vm"
    admin_username = var.username
    admin_password = var.password
    }

    os_profile_linux_config {
    disable_password_authentication = false
    }
}

resource "azurerm_public_ip" "vpn-gateway1-pip" {
    name                = "${local.prefix}-gateway1-pip"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vpn-gateway" {
    name                = "vpn-gateway1"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    type     = "Vpn"
    vpn_type = "RouteBased"

    active_active = false
    enable_bgp    = false
    sku           = "VpnGw1"

    ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn-gateway1-pip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.subnet.id
    }
    depends_on = [azurerm_public_ip.vpn-gateway1-pip]
}