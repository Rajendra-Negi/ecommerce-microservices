package terraform

default restrict_regions = false

restrict_regions if {
  every rc in input.resource_changes {
    rc.change.after.location == "eastus"
  }
}
