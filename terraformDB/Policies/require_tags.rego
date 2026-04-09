package terraform

default allow = false

allow if {
  every rc in input.resource_changes {
    rc.change.after.tags["environment"]
  }
}
