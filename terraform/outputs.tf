output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "gitlab_ip" {
  value = azurerm_public_ip.gitlab_ip.ip_address
}

output "k8s_main_ip" {
  value = azurerm_public_ip.k8s_main_ip.ip_address
}

output "k8s_worker_ip" {
  value = azurerm_public_ip.k8s_worker_ip.ip_address
}
