# Data sources for EKS module

data "aws_ami" "eks_worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${var.kubernetes_version}-*"]
  }

  most_recent = true
  owners      = ["amazon"]
}
