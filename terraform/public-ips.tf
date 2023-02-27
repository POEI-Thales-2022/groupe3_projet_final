resource "azurerm_public_ip" "k8s_main_ip" {
  name                = "k8s-main-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "hal-front"
}
output "k8s_main_public_ip" {
  value = azurerm_public_ip.k8s_main_ip.ip_address
}
resource "azurerm_public_ip" "k8s_worker_ip" {
  name                = "k8s-worker-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}
output "k8s_worker_public_ip" {
  value = azurerm_public_ip.k8s_worker_ip.ip_address
}
resource "azurerm_public_ip" "iscsi_ip" {
  name                = "iscsi-ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
}
output "iscsi_public_ip" {
  value = azurerm_public_ip.iscsi_ip.ip_address
}
