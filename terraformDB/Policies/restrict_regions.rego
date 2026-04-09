package terraform

default allow = false

allow {
  every rc in input.resource_changes {
    rc.change.after.location == "eastus"
  }
}
