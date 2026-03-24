resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = var.cluster_name
  kubernetes_version  = var.kubernetes_version

  default_node_pool {
    name                = "agentpool"
    node_count          = var.enable_auto_scaling ? null : var.node_count
    vm_size             = var.vm_size
    os_disk_size_gb     = var.os_disk_size_gb
    os_disk_type        = "Managed"
    vnet_subnet_id      = null

    enable_auto_scaling = var.enable_auto_scaling
    min_count           = var.enable_auto_scaling ? var.min_count : null
    max_count           = var.enable_auto_scaling ? var.max_count : null

    type                = "VirtualMachineScaleSets"
    availability_zones  = ["1"]

    tags = var.tags
  }

  identity {
    type = var.enable_managed_identity ? "SystemAssigned" : "UserAssigned"
  }

  network_profile {
    network_plugin      = var.network_plugin
    network_plugin_mode = var.network_plugin_mode
    load_balancer_sku   = var.load_balancer_sku
    outbound_type       = "loadBalancer"
  }

  dynamic "microsoft_defender" {
    for_each = var.environment == "prod" ? [1] : []
    content {
      enabled = true
    }
  }

  api_server_access_profile {
    authorized_ip_ranges = length(var.api_server_authorized_ip_ranges) > 0 ? var.api_server_authorized_ip_ranges : null
  }

  addon_profile {
    oms_agent {
      enabled                    = var.enable_monitoring
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }

    azure_policy {
      enabled = var.environment == "prod"
    }
  }

  tags = var.tags

  depends_on = [
    azurerm_resource_group.aks
  ]
}

# Data source to get kubeconfig
resource "null_resource" "get_kubeconfig" {
  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${azurerm_resource_group.aks.name} --name ${azurerm_kubernetes_cluster.aks.name} --overwrite-existing"
  }

  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]
}
