output "vault_id"     { value = azurerm_recovery_services_vault.backup.id }
output "vault_name"   { value = azurerm_recovery_services_vault.backup.name }
output "policy_ids"   { value = { for k, p in azurerm_backup_policy_vm.this : k => p.id } }
output "policy_names" { value = { for k, p in azurerm_backup_policy_vm.this : k => p.name } }

