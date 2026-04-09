package terraform

default require_tags = false

require_tags if {
  every rc in input.resource_changes {
    rc.change.after.tags["environment"]
  }
}
