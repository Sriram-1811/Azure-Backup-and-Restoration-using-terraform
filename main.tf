locals {
  servers_raw = csvdecode(file("${path.module}/wave-plan/servers.csv"))

  rsv_instances = {
    for s in local.servers_raw :
    s.TargetLocation => {
      location            = s.TargetLocation
      resource_group_name = s.RSV_RG
    }
  }

  backup_targets = {
    for s in local.servers_raw :
    s.TargetVMName => {
      vm_name             = s.TargetVMName
      resource_group_name = s.TargetRG
      location            = s.TargetLocation
      environment         = s.Environment
      backup_policy       = lower(s.Environment) == "production" ? "gold" : lower(s.BackupPolicy)
      rsv_name            = "rsv-backup-${var.project_name}-${s.TargetLocation}-${var.environment}"
      rsv_rg              = s.RSV_RG
    }
    if lower(s.BackupEnabled) == "true"
  }
}

module "RSV_Policy" {
  for_each = local.rsv_instances

  source = "./Modules/RSV_n_backup_policy"
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  environment = var.environment
  project_name = var.project_name
  tags = var.common_tags
}

module "vm_backup" {
  for_each = local.backup_targets

  source              = "./Modules/vm_backup"
  vm_name             = each.value.vm_name
  resource_group_name = each.value.resource_group_name
  backup_policy       = each.value.backup_policy
  rsv_name            = each.value.rsv_name
  rsv_rg              = each.value.rsv_rg
  project_name        = var.project_name
  environment         = var.environment

  depends_on = [module.RSV_Policy]
}