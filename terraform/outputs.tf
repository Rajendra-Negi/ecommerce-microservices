output "resource_group_id" {
  description = "Resource Group ID"
  value       = azurerm_resource_group.aks.id
}

output "resource_group_name" {
  description = "Resource Group Name"
  value       = azurerm_resource_group.aks.name
}

output "kubernetes_cluster_id" {
  description = "AKS Cluster ID"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "kubernetes_cluster_name" {
  description = "AKS Cluster Name"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "kubernetes_cluster_fqdn" {
  description = "AKS Cluster FQDN"
  value       = azurerm_kubernetes_cluster.aks.fqdn
}

output "kube_config" {
  description = "Raw kubeconfig output"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "kube_config_context" {
  description = "Kubernetes context"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].cluster_name
}

output "client_certificate" {
  description = "Client certificate"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate
  sensitive   = true
}

output "client_key" {
  description = "Client key"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].client_key
  sensitive   = true
}

output "identity" {
  description = "Cluster Identity"
  value = {
    principal_id = azurerm_kubernetes_cluster.aks.identity[0].principal_id
    tenant_id    = azurerm_kubernetes_cluster.aks.identity[0].tenant_id
    type         = azurerm_kubernetes_cluster.aks.identity[0].type
  }
}

output "node_resource_group" {
  description = "Auto-generated resource group for nodes"
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}
