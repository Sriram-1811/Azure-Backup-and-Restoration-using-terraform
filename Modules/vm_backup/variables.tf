variable "vm_name" {
  type        = string
  description = "Name of the VM to protect"
}

variable "resource_group_name" {
  type        = string
  description = "RG where the VM lives (TargetRG from CSV)"
}

variable "rsv_name" {
  type        = string
  description = "Name of the RSV to register the VM to"
}

variable "rsv_rg" {
  type        = string
  description = "RG where the RSV lives (RSV_RG from CSV)"
}

variable "backup_policy" {
  type        = string
  description = "Tier: gold, silver, or bronze"

  validation {
    condition     = contains(["gold", "silver", "bronze"], var.backup_policy)
    error_message = "backup_policy must be gold, silver, or bronze."
  }
}

variable "project_name" {
  type        = string
  description = "Project short name, used to construct policy name"
}

variable "environment" {
  type        = string
  description = "Deployment environment (dev, staging, prod)"
}