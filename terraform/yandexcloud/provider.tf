terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.129.0"
    }
  }
}

provider "yandex" {
  token     = var.YC_TOKEN
  cloud_id  = "ao7iui0n8qvajabbi2dl"
  endpoint  = "api.yandexcloud.kz:443"
  folder_id = local.folder_id
  zone      = local.zone_id
}
