variable "env" {
  description = "The name of the environment"
  type        = string
  default     = "env"
}

variable "project" {
  description = "The name of the project"
  type        = string
  default     = "project"
}

variable "folder_id" {
  type        = string
  default     = null
  description = "The catalog Folder id"
}

variable "network_id" {
  description = "ID of the VPC where to create kubernetes cluster"
  type        = string
  default     = null
}

variable "regional" {
  description = "If true master nodes will be deployed in regional configuration and 'regional_locations' variable must be set. If false master node will be deployed in zonal configuration and 'zonal_location' variable must be set"
  type        = bool
  default     = false
}

variable "zonal_location" {
  description = "Parameters for zonal master (single node master)"
  type        = map(any)
  default     = {}
}

variable "regional_locations" {
  description = "Parameters for regioanl master (HA master)"
  type        = list(any)
  default     = []
}

variable "extra_tags" {
  description = "List of additional tags"
  type        = map(any)
  default     = { managed-by = "terraform" }
}

variable "security_group_ids" {
  description = "List of master security group IDs"
  type        = list(any)
  default     = []
}

variable "ssh_admin_username" {
  description = "SSH username for access to instance"
  type        = string
  default     = "ubuntu"
}

variable "ssh_admin_pub_key" {
  description = "SSH public key for access to instance"
  type        = string
  default     = ""
}

variable "master_version" {
  description = "Version of Kubernetes that will be used for master"
  type        = string
  default     = "1.30"
}

variable "cluster_ipv4_range" {
  description = "CIDR block. IP range for allocating pod addresses. It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets"
  type        = string
  default     = "10.100.0.0/16"
}

variable "service_ipv4_range" {
  description = "CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. It should not overlap with any subnet in the network the Kubernetes cluster located in"
  type        = string
  default     = "10.110.0.0/16"
}

variable "public_ip" {
  description = "If true, Kubernetes master will have public ipv4 address"
  type        = bool
  default     = false
}

variable "upgrade_policy" {
  description = "If true, Kubernet masters will automatically update"
  type        = bool
  default     = false
}

variable "maintenance" {
  description = "Start time and duration of automatic kubernetes masters updates"
  type        = map(string)
  default = {
    "start_time" = "2:00"
    "duration"   = "3h"
  }
}

variable "kms_enable" {
  description = "If true, enable kms symmetric encrypt kubernetes secrets in etcd"
  type        = bool
  default     = false
}

variable "release_channel" {
  description = "Kubernetes cluster release channel"
  type        = string
  default     = "STABLE"
}

variable "network_provider" {
  description = "Network policy provider for the cluster"
  type        = string
  default     = "CALICO"
}

variable "node_resources" {
  description = "Default node group resources"
  type        = map(string)
  default = {
    "cores"          = "2"
    "memory"         = "2"
    "core_fraction"  = "5"
    "platform_id"    = "standard-v2"
    "boot_disk_type" = "network-ssd"
    "boot_disk_size" = "64"
  }
}

variable "node_groups" {
  description = "Map of kubernetes node groups"
  type        = map(any)
}

variable "node_upgrade_policy" {
  description = "If true, kubernetes nodes will automatically update"
  type        = bool
  default     = false
}

variable "node_maintenance" {
  description = "Start time and duration of automatic kubernetes node updates"
  type        = map(string)
  default = {
    day        = "sunday"
    start_time = "2:00"
    duration   = "3h"
  }
}

variable "node_fixed_scale" {
  description = "Default node fixed scale"
  type        = bool
  default     = true
}

variable "fixed_scale" {
  description = "Default instance number in node group"
  type        = map(any)
  default = {
    size = 1
  }
}

variable "auto_scale" {
  description = "Default auto scale configuration for node group"
  type        = map(string)
  default = {
    "min" : "1"
    "max" : "2"
    "initial" : "1"
  }
}
