module "rke-cluster" { 
  source = "../modules/rke-ha"

  rke = {
    cluster_name        = "euro-test"
    dind                = false
    kubernetes_version  = "v1.18.9-rancher1-1"
  }

  rke_nodes = [{
    public_ip   = "x.x.x.x"
    private_ip  = "x.x.x.x"
    hostname    = "x"
    roles       = list("controlplane", "etcd", "worker")
    user        = "root"
    ssh_key     = file("/x/.ssh/id_rsa")
  },
  {
    public_ip   = "x.x.x.x"
    private_ip  = "x.x.x.x"
    hostname    = "x"
    roles       = list("controlplane", "etcd", "worker")
    user        = "root"
    ssh_key     = file("/x/.ssh/id_rsa")
  },
  {
    public_ip   = "x.x.x.x"
    private_ip  = "x.x.x.x"
    hostname    = "x"
    roles       = list("controlplane", "etcd", "worker")
    user        = "root"
    ssh_key     = file("/x/.ssh/id_rsa")
  }]
}

module "rancher_server" { 
  source = "../modules/rancher"

  rancher_hostname = "x.x.com"
  rancher_k8s = {
    host = module.rke-cluster.kubeconfig_api_server_url
    client_certificate     = module.rke-cluster.kubeconfig_client_cert
    client_key             = module.rke-cluster.kubeconfig_client_key
    cluster_ca_certificate = module.rke-cluster.kubeconfig_ca_crt
  }
}

