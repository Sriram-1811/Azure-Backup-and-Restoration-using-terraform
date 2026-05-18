##############################################################################
# Module: vm_backup
# Purpose: Register an existing VM to its matching RSV and assign backup policy
#          RSV is matched by location naming convention.
##############################################################################

# Fetch the VM — will fail loudly if VM doesn't exist yet (intentional)
data "azurerm_virtual_machine" "this" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
}

# Fetch the RSV — constructed name from location + project + environment
data "azurerm_recovery_services_vault" "this" {
  name                = var.rsv_name
  resource_group_name = var.rsv_rg
}

# Fetch the backup policy by tier name
data "azurerm_backup_policy_vm" "this" {
  name                = "bp-${var.backup_policy}-${var.project_name}-${var.environment}"
  recovery_vault_name = data.azurerm_recovery_services_vault.this.name
  resource_group_name = var.rsv_rg
}

# Register VM to RSV with assigned policy
resource "azurerm_backup_protected_vm" "this" {
  resource_group_name = var.rsv_rg
  recovery_vault_name = data.azurerm_recovery_services_vault.this.name
  source_vm_id        = data.azurerm_virtual_machine.this.id
  backup_policy_id    = data.azurerm_backup_policy_vm.this.id
}