resource "azurerm_public_ip" "k8s_lb_ip" {
  name                = "k8s-lb-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = var.k8s_lb_dns
}

resource "azurerm_lb" "k8s_lb" {
  name                = "k8s-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "k8s-lb-ip-conf"
    public_ip_address_id = azurerm_public_ip.k8s_lb_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "k8s_lb_pool" {
  name            = "k8s-lb-pool"
  loadbalancer_id = azurerm_lb.k8s_lb.id
}

resource "azurerm_lb_nat_rule" "k8s_nat" {
  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.k8s_lb.id
  name                           = "k8s-nat"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "k8s-lb-ip-conf"
}

resource "azurerm_network_interface_backend_address_pool_association" "k8s_lb_nic_assoc" {
  network_interface_id    = azurerm_network_interface.k8s_main_nic.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = azurerm_lb_backend_address_pool.k8s_lb_pool.id
}
