variable "kubectl_image" {
  type        = string
  description = "Kubectl docker image"
  default     = "bitnami/kubectl:1.17.4"
}

variable "cert_manager" {
  type = object({
    ns = string
    version = string
    crd_url = string
    chart_set = list(object({
      name = string
      value = string
    }))
  })
  default = {
    ns = "cert-manager"
    version = "v0.15.0"
    crd_url = "https://raw.githubusercontent.com/jetstack/cert-manager/release-0.15/deploy/manifests/00-crds.yaml"
    chart_set = []
  }
  description = "Cert-manager helm chart properties. Chart sets can be added using chart_set param"
}

variable "rancher_server" {
  type = object({
    ns = string
    version = string
    branch = string
    chart_set = list(object({
      name = string
      value = string
    }))
  })
  default = {
    ns        = "cattle-system"
    version   = "v2.4.8"
    branch    = "latest"
    chart_set = []
  }
  description = "Rancher server helm chart properties. Chart sets can be added using chart_set param"
}

variable "rancher_hostname" {
  type = string
  description = "Rancher server hostname to set on deployment"
}

variable "rancher_replicas" {
  type = number
  description = "Rancher server replicas to set on deployment"
  default = 3
}

variable "rancher_k8s" {
  type = object({
    host = string
    client_certificate = string
    client_key = string
    cluster_ca_certificate = string
  })
  description = "K8s cluster client configuration"
}

variable "tls_crt" {
  type = string
  description = "Certificate used for deploying Rancher with custom certs"
}

variable "tls_key" {
  type = string
  description = "Certificate key used for deploying Rancher with custom certs"
}