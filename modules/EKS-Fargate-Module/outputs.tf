output "cluster_id" {
  description = "The name/id of the EKS cluster"
  value       = aws_eks_cluster.this.id
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster"
  value       = aws_eks_cluster.this.arn
}

output "cluster_endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value       = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority_data" {
  description = "Base64 encoded certificate data required to communicate with the cluster"
  value       = aws_eks_cluster.this.certificate_authority[0].data
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = aws_security_group.cluster.id
}

output "fargate_profile_arns" {
  description = "ARNs of the Fargate profiles"
  value       = { for k, v in aws_eks_fargate_profile.profiles : k => v.arn }
}

output "cluster_iam_role_arn" {
  description = "ARN of the IAM role used by EKS"
  value       = aws_iam_role.cluster.arn
}

output "fargate_iam_role_arns" {
  description = "ARNs of the Fargate execution IAM roles"
  value       = { for k, v in aws_iam_role.fargate : k => v.arn }
}

output "kubeconfig" {
  description = "kubectl config file contents for this EKS cluster"
  value       = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.this.endpoint}
    certificate-authority-data: ${aws_eks_cluster.this.certificate_authority[0].data}
  name: ${aws_eks_cluster.this.arn}
contexts:
- context:
    cluster: ${aws_eks_cluster.this.arn}
    user: ${aws_eks_cluster.this.arn}
  name: ${aws_eks_cluster.this.arn}
current-context: ${aws_eks_cluster.this.arn}
kind: Config
preferences: {}
users:
- name: ${aws_eks_cluster.this.arn}
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: aws
      args:
        - "eks"
        - "get-token"
        - "--cluster-name"
        - "${aws_eks_cluster.this.name}"
KUBECONFIG
  sensitive   = true
}