locals {
  servers_raw = csvdecode(file("${path.module}/wave-plan/servers.csv"))

  rsv_instances = {
    for s in local.servers_raw :
    s.TargetLocation => {
      location            = s.TargetLocation
      resource_group_name = s.RSV_RG
    }
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