variable "ssh_key_file_name" {
  type        = string
  description = "File path and name of SSH private key used for infrastructure and RKE"
  default     = "~/.ssh/id_rsa"
}

variable "cluster_name" {
  type = string 
  description = "RKE k8s cluster name used in the kube config"
  default = "rancher_local"
}

variable "dind" {
  type = string 
  description = "(Optional/Experimental) Deploy RKE cluster on a dind environment."
  default = false 
}

variable "kubernetes_version" {
  type = string 
  description = "K8s version to deploy. If kubernetes image is specified, image version takes precedence."
  default = "v1.18.9-rancher1-1"
}

# Node information
locals {
  rke_nodes = [{
    public_ip = "x.x.x.x"
    hostname = "x"
  },
  {
    public_ip = "x.x.x.x"
    hostname = "x"
  },
  {
    public_ip = "x.x.x.x"
    hostname = "x"
  }]
}