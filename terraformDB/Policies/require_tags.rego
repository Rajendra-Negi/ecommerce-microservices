package terraform

default allow = false

allow {
  # iterate over all resource changes
  every rc in input.resource_changes {
    rc.change.after.tags["environment"]
  }
}
