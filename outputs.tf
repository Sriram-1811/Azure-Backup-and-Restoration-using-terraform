##############################################################################
# Root Outputs
# Purpose: Surface RSV details and VM backup registration results
##############################################################################

# ---------------------------------------------------------------------------
# RSV + Policy outputs (from RSV_n_backup_policy module)
# ---------------------------------------------------------------------------
output "recovery_services_vaults" {
  description = "RSVs created per location with their IDs"
  value = {
    for k, v in module.RSV_Policy : k => {
      vault_name          = v.vault_name
      vault_id            = v.vault_id
      location            = k
    }
  }
}

# ---------------------------------------------------------------------------
# VM Backup registration outputs (from vm_backup module)
# ---------------------------------------------------------------------------
output "protected_vms" {
  description = "All VMs registered to backup with their RSV and policy"
  value = {
    for k, v in module.vm_backup : k => {
      protected_vm_id = v.protected_vm_id
      rsv_name        = v.rsv_name
      policy_assigned = v.policy_assigned
    }
  }
}