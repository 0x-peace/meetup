resource "proxmox_vm_qemu" "test-master-k8s" {
  name         = "test-master-k8s"
  desc         = "Created from terraform"
  target_node  = "srv03"
  searchdomain = "egs.kz"
  nameserver   = "195.210.46.132 195.210.46.195"

  clone   = "ubuntu-22.04-cloud-init"
  cores   = 2
  sockets = 2
  memory  = 6144
  agent   = 1
  boot    = "order=virtio0;net0;ide2"

  disk {
    type    = "virtio"
    storage = "ssd"
    size    = "30G"
    format  = "qcow2"
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
  }

  os_type   = "cloud-init"
  ipconfig0 = "ip=192.168.10.190/24,gw=192.168.10.254"
}

resource "proxmox_vm_qemu" "test-worker-k8s" {
  name         = "test-worker-k8s"
  desc         = "Created from terraform"
  target_node  = "srv03"
  searchdomain = "egs.kz"
  nameserver   = "195.210.46.132 195.210.46.195"

  clone   = "ubuntu-22.04-cloud-init"
  cores   = 2
  sockets = 2
  memory  = 6144
  agent   = 1
  boot    = "order=virtio0;net0;ide2"

  disk {
    type    = "virtio"
    storage = "ssd"
    size    = "30G"
    format  = "qcow2"
  }

  network {
    model  = "virtio"
    bridge = "vmbr1"
  }

  os_type   = "cloud-init"
  ipconfig0 = "ip=192.168.10.191/24,gw=192.168.10.254"
}
