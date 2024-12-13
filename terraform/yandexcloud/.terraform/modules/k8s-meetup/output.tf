output "kubernetes_cluster" {
  description = "Yandex Kubernetes Cluster data"
  value       = yandex_kubernetes_cluster.this
}

output "kubernetes_node_groups" {
  description = "Yandex Kubernetes node groups"
  value       = yandex_kubernetes_node_group.this
}
