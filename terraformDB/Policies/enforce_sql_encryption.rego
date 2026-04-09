package terraform

default enforce_sql_encryption = false

enforce_sql_encryption if {
  every rc in input.resource_changes {
    rc.type == "azurerm_mssql_database"
    rc.change.after.transparent_data_encryption_enabled == true
  }
}
