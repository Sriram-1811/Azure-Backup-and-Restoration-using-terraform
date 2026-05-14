##############################################################################
# Module: backup
# Purpose: Recovery Services Vault + tiered backup policies (gold/silver/bronze)
#          for post-migration VM protection.
##############################################################################

locals {
  vault_name = var.vault_name != "" ? var.vault_name : (
    "rsv-backup-${var.project_name}-${var.location}-${var.environment}"
  )
}

resource "azurerm_recovery_services_vault" "backup" {
  name                = local.vault_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
 # soft_delete_enabled = true - By default it's true

  monitoring {
    alerts_for_all_job_failures_enabled            = true
    alerts_for_critical_operation_failures_enabled = true
  }

  tags = merge(var.tags, { component = "backup-vault" })
}

# ---------------------------------------------------------------------------
# VM Backup Policies (tiered: gold / silver / bronze)
# ---------------------------------------------------------------------------
resource "azurerm_backup_policy_vm" "this" {
  for_each = var.backup_policies

  name                = "bp-${each.key}-${var.project_name}-${var.environment}"
  resource_group_name = var.resource_group_name
  recovery_vault_name = azurerm_recovery_services_vault.backup.name
  policy_type         = "V2"

  timezone = "UTC"

  backup {
    frequency = each.value.frequency
    time      = each.value.time
  }

  retention_daily {
    count = each.value.retention_daily
  }

  retention_weekly {
    count    = each.value.retention_weekly
    weekdays = ["Sunday"]
  }

  retention_monthly {
    count    = each.value.retention_monthly
    weekdays = ["Sunday"]
    weeks    = ["First"]
  }

  dynamic "retention_yearly" {
    for_each = each.value.retention_yearly > 0 ? [1] : []
    content {
      count    = each.value.retention_yearly
      weekdays = ["Sunday"]
      weeks    = ["First"]
      months   = ["January"]
    }
  }
}

