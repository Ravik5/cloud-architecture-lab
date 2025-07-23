module "eks_fargate" {
  source = "../../"

  cluster_name    = "my-eks-cluster"
  kubernetes_version = "1.27"
  subnet_ids      = ["subnet-123456", "subnet-789012"]
  vpc_id          = "vpc-123456"

  fargate_profiles = {
    kube-system = {
      namespace = "kube-system"
    }
    default = {
      namespace = "default"
    }
    monitoring = {
      namespace = "monitoring"
      labels = {
        app = "monitoring"
      }
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}