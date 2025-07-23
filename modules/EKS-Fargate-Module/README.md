# Terraform AWS EKS Fargate Module

A production-ready Terraform module for deploying Amazon Elastic Kubernetes Service (EKS) clusters with AWS Fargate profiles.

## Features

- 🛡️ **Secure by Default**: Private cluster endpoint with configurable public access
- ⚡ **Serverless Kubernetes**: Fully managed Fargate profiles for worker nodes
- 🔐 **IAM Integration**: Automatic aws-auth configmap setup
- 📊 **Logging**: CloudWatch logging for control plane
- 🏷️ **Tagging**: Consistent tagging across all resources

## Usage

```hcl
module "eks_fargate" {
  source = "git::https://github.com/Ravik5/cloud-architecture-lab.git//modules/eks-fargate?ref=v1.0.0"

  cluster_name       = "production-eks"
  kubernetes_version = "1.27"
  vpc_id             = "vpc-12345678"
  subnet_ids         = ["subnet-123456", "subnet-789012"]

  fargate_profiles = {
    kube-system = {
      namespace = "kube-system"
    }
    apps = {
      namespace = "apps"
      labels    = { environment = "production" }
    }
  }

  tags = {
    Environment = "production"
    Terraform   = "true"
  }
}