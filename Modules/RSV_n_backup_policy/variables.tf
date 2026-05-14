variable "resource_group_name" { type = string }
variable "location"            { type = string }
variable "environment"         { type = string }
variable "project_name"        { type = string }

variable "vault_name" {
  description = "Override Recovery Services Vault name"
  type        = string
  default     = ""
}

variable "backup_policies" {
  description = "Map of backup policy configurations"
  type = map(object({
    frequency           = string   # Daily or Weekly
    time                = string   # HH:MM UTC
    retention_daily     = optional(number, 0)
    retention_weekly    = number
    retention_monthly   = number
    retention_yearly    = number
  }))
  default = {
    gold = {
      frequency         = "Daily"
      time              = "02:00"
      retention_daily   = 30
      retention_weekly  = 12
      retention_monthly = 12
      retention_yearly  = 3
    }
    silver = {
      frequency         = "Daily"
      time              = "03:00"
      retention_daily   = 14
      retention_weekly  = 8
      retention_monthly = 6
      retention_yearly  = 1
    }
    bronze = {
      frequency         = "Daily"
      time              = "04:00"
      retention_daily   = 7
      retention_weekly  = 4
      retention_monthly = 3
      retention_yearly  = 0
    }
  }
}

variable "tags" { 
  type = map(string)
  default = {} 
}

