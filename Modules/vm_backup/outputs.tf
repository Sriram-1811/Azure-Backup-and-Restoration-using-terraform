output "protected_vm_id" {
  description = "Resource ID of the backup protected VM"
  value       = azurerm_backup_protected_vm.this.id
}

output "vm_name" {
  description = "Name of the protected VM"
  value       = var.vm_name
}

output "rsv_name" {
  description = "RSV the VM was registered to"
  value       = data.azurerm_recovery_services_vault.this.name
}

output "policy_assigned" {
  description = "Backup policy assigned to this VM"
  value       = data.azurerm_backup_policy_vm.this.name
}