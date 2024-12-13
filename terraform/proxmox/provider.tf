terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.7.4"
    }
  }
  required_version = ">= 0.13"
}

provider "proxmox" {
  pm_tls_insecure = true
  pm_api_url      = var.PROXMOX_HOST
  pm_password     = var.PROXMOX_PASS
  pm_user         = var.PROXMOX_USER
}
