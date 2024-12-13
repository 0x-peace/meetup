# managed-kubernetes

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | ~> 0.129.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | ~> 0.129.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_iam_service_account.master](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account) | resource |
| [yandex_iam_service_account.node](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account) | resource |
| [yandex_kms_symmetric_key.k8s-kms-key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kms_symmetric_key) | resource |
| [yandex_kubernetes_cluster.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster) | resource |
| [yandex_kubernetes_node_group.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group) | resource |
| [yandex_resourcemanager_folder_iam_member.k8s-master](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder_iam_member) | resource |
| [yandex_resourcemanager_folder_iam_member.k8s-node](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/resourcemanager_folder_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_scale"></a> [auto\_scale](#input\_auto\_scale) | Default auto scale configuration for node group | `map(string)` | <pre>{<br>  "initial": "1",<br>  "max": "2",<br>  "min": "1"<br>}</pre> | no |
| <a name="input_cluster_ipv4_range"></a> [cluster\_ipv4\_range](#input\_cluster\_ipv4\_range) | CIDR block. IP range for allocating pod addresses. It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be set up for this CIDR blocks in node subnets | `string` | `"10.100.0.0/16"` | no |
| <a name="input_env"></a> [env](#input\_env) | The name of the environment | `string` | `"env"` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | List of additional tags | `map(any)` | <pre>{<br>  "managed-by": "terraform"<br>}</pre> | no |
| <a name="input_fixed_scale"></a> [fixed\_scale](#input\_fixed\_scale) | Default instance number in node group | `map(any)` | <pre>{<br>  "size": 1<br>}</pre> | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The catalog Folder id | `string` | `null` | no |
| <a name="input_kms_enable"></a> [kms\_enable](#input\_kms\_enable) | If true, enable kms symmetric encrypt kubernetes secrets in etcd | `bool` | `false` | no |
| <a name="input_maintenance"></a> [maintenance](#input\_maintenance) | Start time and duration of automatic kubernetes masters updates | `map(string)` | <pre>{<br>  "duration": "3h",<br>  "start_time": "2:00"<br>}</pre> | no |
| <a name="input_master_version"></a> [master\_version](#input\_master\_version) | Version of Kubernetes that will be used for master | `string` | `"1.30"` | no |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | ID of the VPC where to create kubernetes cluster | `string` | `null` | no |
| <a name="input_network_provider"></a> [network\_provider](#input\_network\_provider) | Network policy provider for the cluster | `string` | `"CALICO"` | no |
| <a name="input_node_fixed_scale"></a> [node\_fixed\_scale](#input\_node\_fixed\_scale) | Default node fixed scale | `bool` | `true` | no |
| <a name="input_node_groups"></a> [node\_groups](#input\_node\_groups) | Map of kubernetes node groups | `map(any)` | n/a | yes |
| <a name="input_node_maintenance"></a> [node\_maintenance](#input\_node\_maintenance) | Start time and duration of automatic kubernetes node updates | `map(string)` | <pre>{<br>  "day": "sunday",<br>  "duration": "3h",<br>  "start_time": "2:00"<br>}</pre> | no |
| <a name="input_node_resources"></a> [node\_resources](#input\_node\_resources) | Default node group resources | `map(string)` | <pre>{<br>  "boot_disk_size": "64",<br>  "boot_disk_type": "network-ssd",<br>  "core_fraction": "5",<br>  "cores": "2",<br>  "memory": "2",<br>  "platform_id": "standard-v2"<br>}</pre> | no |
| <a name="input_node_upgrade_policy"></a> [node\_upgrade\_policy](#input\_node\_upgrade\_policy) | If true, kubernetes nodes will automatically update | `bool` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | The name of the project | `string` | `"project"` | no |
| <a name="input_public_ip"></a> [public\_ip](#input\_public\_ip) | If true, Kubernetes master will have public ipv4 address | `bool` | `false` | no |
| <a name="input_regional"></a> [regional](#input\_regional) | If true master nodes will be deployed in regional configuration and 'regional\_locations' variable must be set. If false master node will be deployed in zonal configuration and 'zonal\_location' variable must be set | `bool` | `false` | no |
| <a name="input_regional_locations"></a> [regional\_locations](#input\_regional\_locations) | Parameters for regioanl master (HA master) | `list(any)` | `[]` | no |
| <a name="input_release_channel"></a> [release\_channel](#input\_release\_channel) | Kubernetes cluster release channel | `string` | `"STABLE"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of master security group IDs | `list(any)` | `[]` | no |
| <a name="input_service_ipv4_range"></a> [service\_ipv4\_range](#input\_service\_ipv4\_range) | CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from. It should not overlap with any subnet in the network the Kubernetes cluster located in | `string` | `"10.110.0.0/16"` | no |
| <a name="input_ssh_admin_pub_key"></a> [ssh\_admin\_pub\_key](#input\_ssh\_admin\_pub\_key) | SSH public key for access to instance | `string` | `""` | no |
| <a name="input_ssh_admin_username"></a> [ssh\_admin\_username](#input\_ssh\_admin\_username) | SSH username for access to instance | `string` | `"ubuntu"` | no |
| <a name="input_upgrade_policy"></a> [upgrade\_policy](#input\_upgrade\_policy) | If true, Kubernet masters will automatically update | `bool` | `false` | no |
| <a name="input_zonal_location"></a> [zonal\_location](#input\_zonal\_location) | Parameters for zonal master (single node master) | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubernetes_cluster"></a> [kubernetes\_cluster](#output\_kubernetes\_cluster) | Yandex Kubernetes Cluster data |
| <a name="output_kubernetes_node_groups"></a> [kubernetes\_node\_groups](#output\_kubernetes\_node\_groups) | Yandex Kubernetes node groups |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
