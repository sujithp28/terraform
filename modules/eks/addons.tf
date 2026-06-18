# EKS Add-ons Configuration

# VPC CNI Add-on
resource "aws_eks_addon" "vpc_cni" {
  cluster_name             = aws_eks_cluster.main.name
  addon_name               = "vpc-cni"
  addon_version            = var.vpc_cni_addon_version
  service_account_role_arn = aws_iam_role.vpc_cni.arn
  resolve_conflicts        = "OVERWRITE"

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-vpc-cni"
    }
  )
}

# IAM Role for VPC CNI
resource "aws_iam_role" "vpc_cni" {
  name_prefix           = "eks-vpc-cni-"
  assume_role_policy    = data.aws_iam_policy_document.vpc_cni_assume_role.json
  permissions_boundary  = var.iam_role_permissions_boundary

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-vpc-cni-role"
    }
  )
}

data "aws_iam_policy_document" "vpc_cni_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "vpc_cni" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.vpc_cni.name
}

# CoreDNS Add-on
resource "aws_eks_addon" "coredns" {
  cluster_name      = aws_eks_cluster.main.name
  addon_name        = "coredns"
  addon_version     = var.coredns_addon_version
  resolve_conflicts = "OVERWRITE"

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-coredns"
    }
  )
}

# kube-proxy Add-on
resource "aws_eks_addon" "kube_proxy" {
  cluster_name      = aws_eks_cluster.main.name
  addon_name        = "kube-proxy"
  addon_version     = var.kube_proxy_addon_version
  resolve_conflicts = "OVERWRITE"

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-kube-proxy"
    }
  )
}

# EBS CSI Driver Add-on
resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name             = aws_eks_cluster.main.name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = var.ebs_csi_driver_addon_version
  service_account_role_arn = aws_iam_role.ebs_csi_driver.arn
  resolve_conflicts        = "OVERWRITE"

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-ebs-csi-driver"
    }
  )
}

# IAM Role for EBS CSI Driver
resource "aws_iam_role" "ebs_csi_driver" {
  name_prefix           = "eks-ebs-csi-driver-"
  assume_role_policy    = data.aws_iam_policy_document.ebs_csi_driver_assume_role.json
  permissions_boundary  = var.iam_role_permissions_boundary

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-ebs-csi-driver-role"
    }
  )
}

data "aws_iam_policy_document" "ebs_csi_driver_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.ebs_csi_driver.name
}

# EFS CSI Driver Add-on
resource "aws_eks_addon" "efs_csi_driver" {
  count                    = var.enable_efs_csi_driver ? 1 : 0
  cluster_name             = aws_eks_cluster.main.name
  addon_name               = "aws-efs-csi-driver"
  addon_version            = var.efs_csi_driver_addon_version
  service_account_role_arn = aws_iam_role.efs_csi_driver[0].arn
  resolve_conflicts        = "OVERWRITE"

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-efs-csi-driver"
    }
  )
}

# IAM Role for EFS CSI Driver
resource "aws_iam_role" "efs_csi_driver" {
  count                 = var.enable_efs_csi_driver ? 1 : 0
  name_prefix           = "eks-efs-csi-driver-"
  assume_role_policy    = data.aws_iam_policy_document.efs_csi_driver_assume_role[0].json
  permissions_boundary  = var.iam_role_permissions_boundary

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-efs-csi-driver-role"
    }
  )
}

data "aws_iam_policy_document" "efs_csi_driver_assume_role" {
  count = var.enable_efs_csi_driver ? 1 : 0
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringEquals"
      variable = "${replace(aws_eks_cluster.main.identity[0].oidc[0].issuer, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:efs-csi-controller-sa"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "efs_csi_driver" {
  count      = var.enable_efs_csi_driver ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"
  role       = aws_iam_role.efs_csi_driver[0].name
}
