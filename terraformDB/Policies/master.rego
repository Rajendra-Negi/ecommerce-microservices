package terraform

default allow = false

allow if {
  data.terraform.require_tags
  data.terraform.restrict_regions
  data.terraform.enforce_sql_encryption
}
