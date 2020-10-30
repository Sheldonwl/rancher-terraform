# This image is used for running Terraform in an air-gapped environment.
# Make sure to set the correct versions, archetecture and location where to download the .zip files from. 
# Make sure to also use a base image that has access to the internal package repos or already has the necessary packages installed. 

FROM centos:centos7

ENV TERRAFORM_VERSION=0.13.5
ENV HELM_VERSION=1.2.4
ENV KUBERNETES_VERSION=1.12.0
ENV LOCAL_VERSION=2.0.0
ENV RKE_VERSION=1.1.3
ENV ARCH=linux_amd64
ENV ZIP_LOC=https://releases.hashicorp.com/

WORKDIR /home/

# Install packages
RUN yum update -y && yum install wget unzip git -y && \
mkdir -p ~/.terraform.d/plugins/registry.terraform.io/hashicorp/helm/$HELM_VERSION/  && \
mkdir -p ~/.terraform.d/plugins/registry.terraform.io/hashicorp/kubernetes/$KUBERNETES_VERSION/  && \
mkdir -p ~/.terraform.d/plugins/registry.terraform.io/hashicorp/local/$LOCAL_VERSION/  && \
mkdir -p ~/.terraform.d/plugins/registry.terraform.io/rancher/rke/$RKE_VERSION/  && \
# Install Terraform
wget $ZIP_LOC/terraform/0.13.5/terraform_$TERRAFORM_VERSION_$ARCH.zip && \ 
unzip terraform_$TERRAFORM_VERSION_$ARCH && \
mv ./terraform /usr/local/bin/ && \
# Install Helm provider 
wget $ZIP_LOC/terraform-provider-helm/$HELM_VERSION/terraform-provider-helm_$HELM_VERSION_$ARCH.zip && \ 
unzip terraform-provider-helm_$HELM_VERSION_$ARCH && \
mv terraform-provider-helm_vHELM_VERSION* ~/.terraform.d/plugins/ && \
# Install Kubernetes provider 
wget $ZIP_LOC/terraform-provider-kubernetes/$KUBERNETES_VERSION/terraform-provider-kubernetes_$KUBERNETES_VERSION_$ARCH.zip && \ 
unzip terraform-provider-kubernetes_$KUBERNETES_VERSION_$ARCH.zip && \
mv terraform-provider-kubernetes_v$KUBERNETES_VERSION* ~/.terraform.d/plugins/ && \
# Install Local provider
wget $ZIP_LOC/terraform-provider-local/$LOCAL_VERSION/terraform-provider-local_$LOCAL_VERSION_$ARCH.zip && \ 
unzip terraform-provider-local_$LOCAL_VERSION_$ARCH.zip && \
mv terraform-provider-local_v$LOCAL_VERSION* ~/.terraform.d/plugins/ && \
# Install Rancher RKE provider
wget https://github.com/rancher/terraform-provider-rke/releases/download/v$RKE_VERSION/terraform-provider-rke_$RKE_VERSION_$ARCH.zip && \ 
unzip terraform-provider-rke_$RKE_VERSION_$ARCH.zip && \
mv terraform-provider-rke_v$RKE_VERSION ~/.terraform.d/plugins/ && \
# Cleanup image
rm -rf /home/* && yum clean all

# Images for Rancher 
# wget https://github.com/rancher/rancher/releases/download/v2.4.8/rancher-images.txt

# Run Terraform in the container:
# terraform init 
# terraform apply 