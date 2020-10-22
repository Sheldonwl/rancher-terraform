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

# Local variables used to reduce repetition
locals {
  # Node information
  rke_nodes = [{
    public_ip = "128.199.43.14"
    private_ip = "10.133.0.2"
    hostname = "sh-euro-0"
  },
  {
    public_ip = "128.199.44.97"
    private_ip = "10.133.0.3"
    hostname = "sh-euro-1"
  },
  {
    public_ip = "128.199.45.216"
    private_ip = "10.133.0.4"
    hostname = "sh-euro-2"
  }]
}