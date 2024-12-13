module "k8s" {
  source = "../modules/yandex-cloud/managed-kubernetes"

  folder_id  = ""
  project    = ""
  env        = ""
  network_id = module.vpc.network.id

  zonal_location = {
    "zone" : "ru-central1-a"
    "subnet_id" : ""
  }

  node_groups = {
    zone-a = {
      platform_id   = "standard-v2"
      memory        = 8
      cores         = 4
      core_fraction = 100
      subnet_id     = [module.vpc.subnets["cbc-public-1"].id]
    }
  }
}
