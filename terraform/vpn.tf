resource "azurerm_public_ip" "vpn_ip" {
    name                = "vpn-ip"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name
    allocation_method   = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vpn_gateway" {
    name                = "vpn-gateway"
    location            = azurerm_resource_group.rg.location
    resource_group_name = azurerm_resource_group.rg.name

    type     = "Vpn"
    vpn_type = "RouteBased"

    active_active = false
    enable_bgp    = false
    sku           = "VpnGw1"

    ip_configuration {
        name                          = "vpn-gateway"
        public_ip_address_id          = azurerm_public_ip.vpn_ip.id
        private_ip_address_allocation = "Dynamic"
        subnet_id                     = azurerm_subnet.subnet.id
    }
}
