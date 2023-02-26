output "resource_group" {
  value = azurerm_resource_group.rg.name
}

output "k8s_main_ip" {
  value = azurerm_network_interface.k8s_main_nic.private_ip_address
}

output "k8s_main_rid" {
  value = azurerm_linux_virtual_machine.k8s_main.id
}

output "k8s_worker_ip" {
  value = azurerm_network_interface.k8s_worker_nic.private_ip_address
}

output "k8s_worker_rid" {
  value = azurerm_linux_virtual_machine.k8s_worker.id
}

output "iscsi_ip" {
  value = azurerm_network_interface.iscsi_nic.private_ip_address
}

output "gitlab_rid" {
  value = azurerm_linux_virtual_machine.gitlab.id
}

output "gitlab_fqdn" {
  value = azurerm_public_ip.gitlab_ip.fqdn
}

output "bastion_fqdn" {
  value = azurerm_public_ip.bastion_ip.fqdn
}

output "k8s_lb_fqdn" {
  value = azurerm_public_ip.k8s_lb_ip.fqdn
}
