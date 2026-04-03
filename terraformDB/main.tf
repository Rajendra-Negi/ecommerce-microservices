terraform {
  required_version = ">= 1.5.0"
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "tfstateaccount"
    container_name       = "tfstate"
    key                  = "sql.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "sql_database" {
  source = "./modules/sql_database"

  model               = var.model
  server_name         = var.server_name
  resource_group_name = var.resource_group_name
  location            = var.location
  admin_login         = var.admin_login
  admin_password      = var.admin_password
  db_name             = var.db_name

  service_objective = var.service_objective
  capacity          = var.capacity
  auto_pause_delay  = var.auto_pause_delay
  min_capacity      = var.min_capacity
  max_capacity      = var.max_capacity
  pool_name         = var.pool_name
}
