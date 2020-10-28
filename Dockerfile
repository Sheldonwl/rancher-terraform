FROM centos:centos7

WORKDIR /home/

# Install packages
RUN yum update -y && yum install wget unzip git -y && \
mkdir -p ~/.terraform.d/plugins  && \
# Install Terraform
wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip && \ 
unzip terraform_0.13.5_linux_amd64 && \
mv ./terraform /usr/local/bin/ && \
# Install Helm provider 
wget https://releases.hashicorp.com/terraform-provider-helm/1.2.4/terraform-provider-helm_1.2.4_linux_amd64.zip && \ 
unzip terraform-provider-helm_1.2.4_linux_amd64 && \
mv terraform-provider-helm_v1.2.4_x4 ~/.terraform.d/plugins/ && \
# Install Kubernetes provider 
wget https://releases.hashicorp.com/terraform-provider-kubernetes/1.12.0/terraform-provider-kubernetes_1.12.0_linux_amd64.zip && \ 
unzip terraform-provider-kubernetes_1.12.0_linux_amd64.zip && \
mv terraform-provider-kubernetes_v1.12.0_x4 ~/.terraform.d/plugins/ && \
# Install Local provider
wget https://releases.hashicorp.com/terraform-provider-local/2.0.0/terraform-provider-local_2.0.0_linux_amd64.zip && \ 
unzip terraform-provider-local_2.0.0_linux_amd64.zip && \
mv terraform-provider-local_v2.0.0_x5 ~/.terraform.d/plugins/ && \
# Install Rancher RKE provider
wget https://github.com/rancher/terraform-provider-rke/releases/download/v1.1.3/terraform-provider-rke_1.1.3_linux_amd64.zip && \ 
unzip terraform-provider-rke_1.1.3_linux_amd64.zip && \
mv terraform-provider-rke_v1.1.3 ~/.terraform.d/plugins/ && \
# Cleanup image
rm -rf /home/* && yum clean all

# Images for Rancher 
# wget https://github.com/rancher/rancher/releases/download/v2.4.8/rancher-images.txt

# Run Terraform in the container:
# terraform init 
# terraform apply 