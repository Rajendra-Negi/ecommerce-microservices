package terraform

default allow = false

allow {
  all tfplan.resource_changes as rc {
    rc.change.after.tags["environment"]
  }
}
