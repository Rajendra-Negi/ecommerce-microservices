resource "azurerm_mssql_server" "main" {
  name                         = "${var.server_name}-raj"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.admin_password
}

resource "azurerm_mssql_elasticpool" "pool" {
  count               = var.model == "elasticpool" ? 1 : 0
  name                = var.pool_name
  location            = var.location
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mssql_server.main.name

  per_database_settings {
    min_capacity = var.min_capacity
    max_capacity = var.max_capacity
  }

  sku {
    name     = "GP_Gen5"
    tier     = "GeneralPurpose"
    capacity = var.capacity
  }
}

resource "azurerm_mssql_database" "db" {
  name      = var.db_name
  server_id = azurerm_mssql_server.main.id

  # Attach to elastic pool if model = elasticpool
  elastic_pool_id = var.model == "elasticpool" ? azurerm_mssql_elasticpool.pool[0].id : null

  # Single sku_name expression
  sku_name = (
    var.model == "vcore" ? "GP_Gen5_${var.capacity}" :
    var.model == "dtu" ? var.service_objective :
    null
  )
}
