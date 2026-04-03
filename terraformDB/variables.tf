variable "environment" {}
variable "model" {}
variable "server_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "admin_login" {}
variable "admin_password" {}
variable "db_name" {}
variable "service_objective" { default = "S3" }
variable "capacity" { default = 2 }
variable "auto_pause_delay" { default = 60 }
variable "min_capacity" { default = 0.5 }
variable "max_capacity" { default = 2 }
variable "pool_name" { default = "elasticpool1" }
