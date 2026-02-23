FROM mcr.microsoft.com/devcontainers/base:ubuntu

ARG OPENTOFU_VERSION=1.11.5
ARG TERRAFORM_VERSION=1.10.5

USER root

# Install OpenTofu (primary IaC tool)
RUN wget https://github.com/opentofu/opentofu/releases/download/v${OPENTOFU_VERSION}/tofu_${OPENTOFU_VERSION}_linux_amd64.zip && \
    unzip tofu_${OPENTOFU_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm tofu_${OPENTOFU_VERSION}_linux_amd64.zip

# Install Terraform (alternative, for comparison)
RUN apt-get install unzip && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Install AWS CLI
RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -O ./awscliv2.zip && \
    unzip awscliv2.zip && \
    ./aws/install &&\
    rm -rf ./aws awscliv2.zip
