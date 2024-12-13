module "k8s-meetup" {
  source  = "git.egs.kz/ops/managed-kubernetes/yandexcloud"
  version = "0.0.1"

  folder_id  = local.folder_id
  project    = local.project
  env        = local.env
  network_id = "dbpnscamtap4rumqbib6"

  ssh_admin_username = "ubuntu"
  ssh_admin_pub_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDJ6IesRtNExhKH+J8K2B1jxhLhrne3Wo9xKoh7rIODgLt4zS1pBZHyvW9nUr84rWEwwjlKxEmzhANjw53C/CJhWADL/dubcZSk9yMk3Eo4QYnwEr03ZoXFlyiz59qYt/eJHEqu7crFBQ/oTD1GrHZyCzyNsAkBLc3Eqyo2FRkjOmnQ7KwE3Je0j1YWv+ldYLnaoSQqNReoBf+Mkxm4GNmK5sXK+e5173XTwJAzUIuCPsqUGA8+pCbJSm+KPMX4sauCKBFlYsQzK4DXmOp4byynARqqJ5xCriTzsW4NS8Nx1a8/pYfXjWdkkmE8fs3rpG67D9KkMT+n4HeCJZLcR1jrdZX0Text7Zwla0XgxRwsKvWOaBJpxWUmryWlwEdDTOQFytTw+znyaY9xo7CYuw50v5JDF6zPgrk3on2R7qYnx7WGLPUY6h+YzlqCy4DAsX5eRr94C0OAq5pp3w0zsIZQZht5v/1Y/W+u3aX+xRGjsz5KLLQyziVjrw+hyYGG2tW1eO0SpDm/UnrV53PYTtC0st4U9ibO4mMvDRIHEzLP+pz4jJvfbTKVuX1xG8vc5aYL3LBWaMRd7cGRJJoZUI1TpmVETa/PdLOWuSV5BWgpdi7pUW0nbGBLypX+0Xa5pRtsgTVZ7YSHKOpNngMAlLmimtwLIgjcFwQVqgCa25yJUQ== ikondratyev@MacBook-Air-Ivan-2.local"
  public_ip          = true

  zonal_location = {
    "zone" : local.zone_id
    "subnet_id" : "ad14dd7adni3q3ld84qt"
  }

  fixed_scale = {
    size = 1
  }

  upgrade_policy = true
  maintenance = {
    "start_time" = "1:00"
    "duration"   = "3h"
  }

  node_upgrade_policy = true
  node_maintenance = {
    day        = "sunday"
    start_time = "2:00"
    duration   = "3h"
  }

  node_groups = {
    zone-a = {
      platform_id   = "standard-v3"
      memory        = 8
      cores         = 4
      core_fraction = 100
      subnet_id = [
        "ad14dd7adni3q3ld84qt"
      ]
    }
  }
}
