
module "k8s-prod" {
  source = "../modules/yandex-cloud/managed-kubernetes"

  # Master group variables
  folder_id          = ""
  project            = ""
  env                = ""
  network_id         = module.vpc.network.id
  ssh_admin_username = "ubuntu"
  ssh_admin_pub_key  = "ssh-rsa ..."
  kms_enable         = true
  regional           = true
  upgrade_policy     = true
  maintenance = {
    "start_time" = "2:00"
    "duration"   = "3h"
  }
  regional_locations = [
    {
      zone      = module.vpc.subnets["cbc-public-1"].zone
      subnet_id = module.vpc.subnets["cbc-public-1"].id
    },
    {
      zone      = module.vpc.subnets["cbc-public-2"].zone
      subnet_id = module.vpc.subnets["cbc-public-2"].id
    },
    {
      zone      = module.vpc.subnets["cbc-public-3"].zone
      subnet_id = module.vpc.subnets["cbc-public-3"].id
    },
  ]

  # Node group variables
  node_fixed_scale    = true
  node_upgrade_policy = true
  auto_scale = {
    "min"     = "1"
    "max"     = "2"
    "initial" = "1"
  }
  node_maintenance = {
    day        = "sunday"
    start_time = "2:00"
    duration   = "3h"
  }
  node_groups = {
    zone-a = {
      platform_id   = "standard-v2"
      memory        = 8
      cores         = 4
      core_fraction = 100
      subnet_id     = [module.vpc.subnets["cbc-public-1"].id]
      allocation_policy = [{
        zone = module.vpc.subnets["cbc-public-1"].zone
      }]
    }
    zone-b = {
      platform_id   = "standard-v2"
      memory        = 8
      cores         = 4
      core_fraction = 100
      subnet_id     = [module.vpc.subnets["cbc-public-2"].id]
      allocation_policy = [{
        zone = module.vpc.subnets["cbc-public-2"].zone
      }]
    }
    zone-c = {
      platform_id   = "standard-v2"
      memory        = 8
      cores         = 4
      core_fraction = 100
      subnet_id     = [module.vpc.subnets["cbc-public-3"].id]
      allocation_policy = [{
        zone = module.vpc.subnets["cbc-public-3"].zone
      }]
    }
  }
}
