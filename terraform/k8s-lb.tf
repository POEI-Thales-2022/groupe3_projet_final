resource "azurerm_public_ip" "k8s_lb_ip" {
  name                = "k8s-lb-ip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb" "k8s_lb" {
  name                = "k8s-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "k8s-ip-conf"
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
  frontend_port_start            = 80
  frontend_port_end              = 80
  backend_port                   = 80
  backend_address_pool_id        = azurerm_lb_backend_address_pool.k8s_lb_pool.id
  frontend_ip_configuration_name = "k8s-ip-conf"
}

resource "azurerm_lb_backend_address_pool_address" "k8s_lb_pool_add" {
  name                    = "k8s-lb-pool-add"
  backend_address_pool_id = azurerm_lb_backend_address_pool.k8s_lb_pool.id
  virtual_network_id      = azurerm_virtual_network.vnet.id
  ip_address              = var.metallb_first_ip
}

output "k8s_lb_public_ip" {
    value = azurerm_public_ip.k8s_lb_ip.ip_address
}
