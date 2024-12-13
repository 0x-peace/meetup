locals {
  name = "${var.project}-${var.env}-kubernetes"
}

resource "yandex_iam_service_account" "master" {
  name        = "${local.name}-master"
  description = "Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster"
  folder_id   = var.folder_id
}

resource "yandex_iam_service_account" "node" {
  name        = "${local.name}-node"
  description = "Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry or to push node logs and metrics"
  folder_id   = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-master" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.master.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-node" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.node.id}"
}

resource "yandex_kms_symmetric_key" "k8s-kms-key" {
  for_each = var.kms_enable ? { kms = "" } : {}

  name              = "${local.name}-kms-key"
  description       = "Kubernetes KMS secret key"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" // equal to 1 year

  lifecycle {
    prevent_destroy = true
  }
}

### Kubernetes masters
resource "yandex_kubernetes_cluster" "this" {
  name                    = local.name
  description             = "${local.name} cluster"
  service_account_id      = yandex_iam_service_account.master.id
  node_service_account_id = yandex_iam_service_account.node.id
  network_id              = var.network_id
  cluster_ipv4_range      = var.cluster_ipv4_range
  service_ipv4_range      = var.service_ipv4_range
  release_channel         = var.release_channel
  network_policy_provider = var.network_provider

  master {

    version   = var.master_version
    public_ip = var.public_ip

    dynamic "zonal" {
      for_each = var.regional ? [] : [1]
      content {
        zone      = var.zonal_location["zone"]
        subnet_id = var.zonal_location["subnet_id"]
      }
    }

    dynamic "regional" {
      for_each = var.regional ? [1] : []
      content {
        region = "ru-central1"
        dynamic "location" {
          for_each = var.regional_locations
          content {
            zone      = location.value["zone"]
            subnet_id = location.value["subnet_id"]
          }
        }
      }
    }

    maintenance_policy {
      auto_upgrade = var.upgrade_policy

      dynamic "maintenance_window" {
        for_each = var.upgrade_policy ? [1] : []
        content {
          start_time = var.maintenance["start_time"]
          duration   = var.maintenance["duration"]
        }
      }
    }
  }

  dynamic "kms_provider" {
    for_each = var.kms_enable ? [1] : []
    content {
      key_id = yandex_kms_symmetric_key.k8s-kms-key["kms"].id
    }
  }

  labels = merge({
    name    = local.name
    env     = var.env
    project = var.project
    },
    var.extra_tags
  )

  depends_on = [
    yandex_iam_service_account.master,
    yandex_iam_service_account.node,
    yandex_resourcemanager_folder_iam_member.k8s-master,
    yandex_resourcemanager_folder_iam_member.k8s-node,
    yandex_kms_symmetric_key.k8s-kms-key
  ]
}

### Kubernetes nodes
resource "yandex_kubernetes_node_group" "this" {
  for_each = var.node_groups

  cluster_id  = yandex_kubernetes_cluster.this.id
  version     = var.master_version
  name        = "${local.name}-${each.key}"
  description = lookup(each.value, "description", "Default workload node group (zone a)")
  node_labels = lookup(each.value, "node_labels", {})
  node_taints = lookup(each.value, "node_taints", [])

  instance_template {
    platform_id = lookup(each.value, "platform_id", var.node_resources["platform_id"])

    network_interface {
      subnet_ids         = lookup(each.value, "subnet_id", false)
      nat                = lookup(each.value, "nat", false)
      security_group_ids = lookup(each.value, "security_group_ids", null)
    }

    resources {
      cores         = lookup(each.value, "cores", var.node_resources["cores"])
      memory        = lookup(each.value, "memory", var.node_resources["memory"])
      core_fraction = lookup(each.value, "core_fraction", var.node_resources["core_fraction"])
    }

    metadata = {
      ssh-keys = "${var.ssh_admin_username}:${var.ssh_admin_pub_key}"
    }

    boot_disk {
      type = lookup(each.value, "boot_disk_type", var.node_resources["boot_disk_type"])
      size = lookup(each.value, "boot_disk_size", var.node_resources["boot_disk_size"])
    }

    scheduling_policy {
      preemptible = lookup(each.value, "preemptible", false)
    }
  }

  scale_policy {
    dynamic "fixed_scale" {
      for_each = var.node_fixed_scale ? [1] : []
      content {
        size = try(each.value.fixed_scale["size"], var.fixed_scale["size"])
      }
    }
    dynamic "auto_scale" {
      for_each = var.node_fixed_scale ? [] : [1]
      content {
        min     = try(each.value.auto_scale["min"], var.auto_scale["min"])
        max     = try(each.value.auto_scale["max"], var.auto_scale["max"])
        initial = try(each.value.auto_scale["initial"], var.auto_scale["initial"])
      }
    }
  }

  allocation_policy {
    dynamic "location" {
      for_each = lookup(each.value, "allocation_policy", {})
      content {
        zone = location.value["zone"]
      }
    }
  }

  maintenance_policy {
    auto_upgrade = var.node_upgrade_policy
    auto_repair  = var.node_upgrade_policy

    dynamic "maintenance_window" {
      for_each = var.node_upgrade_policy ? [1] : []
      content {
        start_time = var.node_maintenance["start_time"]
        duration   = var.node_maintenance["duration"]
        day        = var.node_maintenance["day"]
      }
    }
  }

  labels = merge({
    name    = local.name
    env     = var.env
    project = var.project
    },
    var.extra_tags
  )

  depends_on = [
    yandex_kubernetes_cluster.this,
  ]
}
