output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "gitlab_ip" {
  value = azurerm_public_ip.gitlab_ip.ip_address
}

output "k8s_main_public_ip" {
  value = azurerm_public_ip.k8s_main_ip.ip_address
}

output "k8s_main_private_ip" {
  value = azurerm_network_interface.k8s_main_nic.private_ip_address
}

output "k8s_worker_public_ip" {
  value = azurerm_public_ip.k8s_worker_ip.ip_address
}

output "k8s_worker_private_ip" {
  value = azurerm_network_interface.k8s_worker_nic.private_ip_address
}

output "iscsi_ip" {
  value = azurerm_public_ip.iscsi_ip.ip_address
}

output "gitlab_dns_name" {
  value = azurerm_public_ip.gitlab_ip.fqdn
}
