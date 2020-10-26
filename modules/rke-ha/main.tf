# Provision RKE cluster on provided infrastructure
resource "rke_cluster" "rancher_cluster" {
  cluster_name = var.rke.cluster_name
  dind = var.rke.dind

  dynamic nodes {
    for_each = var.rke_nodes
    content {
      address           = nodes.value.public_ip
      internal_address  = nodes.value.private_ip
      hostname_override = nodes.value.hostname
      user              = nodes.value.user
      role              = nodes.value.roles
      ssh_key           = nodes.value.ssh_key
    }
  }
  upgrade_strategy {
    drain                        = false
    max_unavailable_controlplane = "1"
    max_unavailable_worker       = "10%"
  }

  kubernetes_version = var.rke.kubernetes_version
}

# Save kube_config_cluster.yml
resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = rke_cluster.rancher_cluster.kube_config_yaml
}