package terraform

# Default rule: deny unless proven compliant
default allow = false

# Allow only if all SQL Databases have encryption enabled
allow {
  all tfplan.resource_changes as rc {
    rc.type == "azurerm_mssql_database"
    rc.change.after.encryption == "Enabled"
  }
}
