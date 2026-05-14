variable "subscription_id" {
  type = string
  default = "72fe83f9-13d1-423d-84c7-0a2b3996813d"
}

variable "tenant_id" {
  type = string
  default = "55d926b4-5090-454c-8af8-c7ce02cf2e96"
}

/*variable "location" {
  type = string
}*/

variable "project_name" {
  type = string
  default = "TCW"
}

/*variable "resource_group_name" {
  type = string
}*/

variable "environment" {
  type = string
  default = "dev"
}

variable "common_tags" {
  description = "Tags applied to every resource in this root module"
  type        = map(string)
  default     = {
  environment         = "dev"
  project             = "tcwproj"
  owner               = "platform-team@example.com"
  cost-center         = "CC-1234"
  workload            = "azure-migration"
  migration-wave      = "wave1"
  criticality         = "low"
  data-classification = "internal"
  }
}

/*variable "common_tags" {
  description = "Tags applied to every resource in this root module"
  type        = map(string)
  default     = {}
}*/