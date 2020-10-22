# Provision RKE cluster on provided infrastructure
resource "rke_cluster" "rancher_cluster" {
  cluster_name = var.cluster_name
  dind = var.dind
  kubernetes_version = var.kubernetes_version

  dynamic nodes {
    for_each = local.rke_nodes
    content {
      address           = nodes.value.public_ip
      internal_address  = nodes.value.private_ip
      hostname_override = nodes.value.hostname 
      user              = "root"
      role              = list("controlplane", "etcd", "worker")
      ssh_key           = file("${var.ssh_key_file_name}")
    }
  }

  upgrade_strategy {
    drain                        = false
    max_unavailable_controlplane = "1"
    max_unavailable_worker       = "10%"
  }
}

# Save kube_config_cluster.yml
resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = rke_cluster.rancher_cluster.kube_config_yaml
}