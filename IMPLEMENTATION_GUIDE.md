# EKS Implementation Guide - Complete Step by Step

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Pre-Deployment Setup](#pre-deployment-setup)
3. [Configuration Steps](#configuration-steps)
4. [Deployment Steps](#deployment-steps)
5. [Post-Deployment Verification](#post-deployment-verification)
6. [EKS Add-ons Installation](#eks-add-ons-installation)
7. [Cleanup](#cleanup)

---

## Prerequisites

### Required Software Installation

#### 1. Terraform Installation (>= 1.0)

**macOS:**
```bash
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
terraform version
```

**Ubuntu/Debian:**
```bash
curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update
sudo apt-get install -y terraform
terraform version
```

**Windows:**
```bash
choco install terraform
terraform version
```

---

#### 2. AWS CLI Installation (>= 2.0)

**macOS:**
```bash
brew install awscli
aws --version
```

**Ubuntu/Debian:**
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version
```

**Windows:**
```bash
choco install awscli
aws --version
```

---

#### 3. kubectl Installation

**macOS:**
```bash
brew install kubectl
kubectl version --client
```

**Ubuntu/Debian:**
```bash
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client
```

**Windows:**
```bash
choco install kubernetes-cli
kubectl version --client
```

---

#### 4. jq Installation (Optional)

**macOS:**
```bash
brew install jq
```

**Ubuntu/Debian:**
```bash
sudo apt-get install jq
```

---

### AWS Credentials Configuration

```bash
# Configure AWS credentials
aws configure

# Verify credentials
aws sts get-caller-identity

# Expected output:
# {
#     "UserId": "AIDAI23HXD2O7FQMGNHQ2",
#     "Account": "123456789012",
#     "Arn": "arn:aws:iam::123456789012:user/your-user"
# }
```

---

### VPC Requirements

Ensure you have:
- 1 VPC
- 2-3 private subnets in different AZs
- NAT Gateway configured
- Internet Gateway attached

**Verify VPC:**
```bash
# List VPCs
aws ec2 describe-vpcs --query 'Vpcs[*].[VpcId,CidrBlock]' --output table

# List subnets
aws ec2 describe-subnets --filters "Name=vpc-id,Values=vpc-xxx" --query 'Subnets[*].[SubnetId,AvailabilityZone]' --output table

# Check NAT Gateway
aws ec2 describe-nat-gateways --query 'NatGateways[*].[NatGatewayId,State]' --output table
```

---

## Pre-Deployment Setup

### Step 1: Gather VPC Information

```bash
# Get VPC ID
VPC_ID=$(aws ec2 describe-vpcs --query 'Vpcs[0].VpcId' --output text)
echo "VPC ID: $VPC_ID"

# Get private subnet IDs
aws ec2 describe-subnets --filters "Name=vpc-id,Values=${VPC_ID}" --query 'Subnets[?MapPublicIpOnLaunch==`false`].[SubnetId,AvailabilityZone]' --output table

# Save for reference
export AWS_REGION="us-east-1"
export VPC_ID="vpc-0a1b2c3d4e5f6g7h"
export SUBNET_IDS='["subnet-12345678", "subnet-87654321", "subnet-11111111"]'
```

---

### Step 2: Clone Repository

```bash
# Clone repository
git clone https://github.com/sujithp28/terraform-aws-infrastructure.git
cd terraform-aws-infrastructure

# Switch to feature/eks branch
git checkout feature/eks

# Verify branch
git branch -v
```

---

## Configuration Steps

### Step 1: Prepare Variables File

```bash
# Navigate to examples directory
cd examples/eks

# Copy example file
cp terraform.tfvars.example terraform.tfvars

# Edit the file
vim terraform.tfvars
```

---

### Step 2: Update terraform.tfvars

```hcl
aws_region    = "us-east-1"
project_name  = "myproject"
environment   = "production"

# Update with YOUR actual values!
vpc_id             = "vpc-0a1b2c3d4e5f6g7h"
private_subnet_ids = [
  "subnet-12345678",
  "subnet-87654321",
  "subnet-11111111"
]

kubernetes_version = "1.29"

# System Node Group
system_desired_size   = 3
system_min_size       = 3
system_max_size       = 10
system_instance_types = ["t3.medium", "t3a.medium"]

# Application Node Group
enable_application_node_group = true
application_desired_size      = 3
application_min_size          = 1
application_max_size          = 20
application_instance_types    = ["t3.large", "t3a.large"]

# GPU Node Group (optional)
enable_gpu_node_group = false

# API Endpoint
endpoint_private_access           = true
endpoint_public_access            = false
cluster_endpoint_private_access_cidrs = ["0.0.0.0/0"]

# Logging
cluster_enabled_log_types    = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
cluster_log_retention_in_days = 30

# Add-ons
enable_efs_csi_driver = false

# Tags
tags = {
  Environment = "production"
  Team        = "platform"
  ManagedBy   = "Terraform"
}
```

---

### Step 3: Initialize Terraform

```bash
# Initialize Terraform
terraform init

# Verify initialization
ls -la .terraform/
```

---

## Deployment Steps

### Step 1: Validate Configuration

```bash
# Validate syntax
terraform validate
```

---

### Step 2: Create Plan

```bash
# Generate deployment plan
terraform plan -out=tfplan

# Review plan (shows ~50+ resources)
terraform show tfplan
```

---

### Step 3: Deploy Cluster

```bash
# Apply configuration
terraform apply tfplan

# Expected deployment time: 20-30 minutes
# DO NOT INTERRUPT!

# Wait for completion...
```

---

### Step 4: Get Cluster Information

```bash
# Export cluster details
terraform output

# Save outputs to file
terraform output -json > eks-outputs.json

# Extract important values
CLUSTER_ID=$(terraform output -raw eks_cluster_id)
CLUSTER_ENDPOINT=$(terraform output -raw eks_cluster_endpoint)
OIDC_ARN=$(terraform output -raw eks_oidc_provider_arn)

echo "Cluster ID: $CLUSTER_ID"
echo "Cluster Endpoint: $CLUSTER_ENDPOINT"
echo "OIDC Provider ARN: $OIDC_ARN"
```

---

## Post-Deployment Verification

### Step 1: Configure kubectl

```bash
# Update kubeconfig
aws eks update-kubeconfig --name $(terraform output -raw eks_cluster_id) --region us-east-1

# Verify connection
kubectl cluster-info
```

---

### Step 2: Check Cluster Nodes

```bash
# List nodes
kubectl get nodes

# Expected output: All nodes in Ready state

# Detailed node info
kubectl describe nodes
```

---

### Step 3: Verify System Pods

```bash
# Check kube-system pods
kubectl get pods -n kube-system

# Expected running pods:
# - aws-node (VPC CNI)
# - coredns
# - kube-proxy
# - aws-ebs-csi-driver pods
```

---

### Step 4: Check CloudWatch Logs

```bash
# View cluster logs
CLUSTER_NAME=$(terraform output -raw eks_cluster_id)
LOG_GROUP="/aws/eks/${CLUSTER_NAME}/cluster"

aws logs tail "$LOG_GROUP" --follow
```

---

### Step 5: Test Kubernetes

```bash
# Deploy test application
kubectl create deployment nginx --image=nginx:latest

# Expose service
kubectl expose deployment nginx --type=LoadBalancer --port=80

# Get load balancer URL
kubectl get svc nginx

# Test
LB_URL=$(kubectl get svc nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
curl http://$LB_URL

# Clean up
kubectl delete svc nginx
kubectl delete deployment nginx
```

---

## EKS Add-ons Installation

### Built-in Add-ons (Automatically Installed)

The module installs:
- ✅ VPC CNI - Pod networking
- ✅ CoreDNS - DNS service
- ✅ kube-proxy - Network proxy
- ✅ EBS CSI Driver - Persistent volumes
- ✅ EFS CSI Driver (optional)

---

### Step 1: Verify Add-ons

```bash
# List add-ons
aws eks list-addons --cluster-name $(terraform output -raw eks_cluster_id)

# Check add-on details
aws eks describe-addon --cluster-name $(terraform output -raw eks_cluster_id) --addon-name vpc-cni
```

---

### Step 2: Verify VPC CNI

```bash
# Check VPC CNI pods
kubectl get daemonset -n kube-system aws-node
kubectl get pods -n kube-system -l k8s-app=aws-node

# Verify IRSA
kubectl get sa -n kube-system aws-node -o jsonpath='{.metadata.annotations}'
```

---

### Step 3: Verify EBS CSI Driver

```bash
# Check EBS CSI deployment
kubectl get deployment -n kube-system ebs-csi-controller
kubectl get daemonset -n kube-system ebs-csi-node

# Test EBS provisioning
cat > test-pvc.yaml << 'EOF'
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ebs-sc
provisioner: ebs.csi.aws.com
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: ebs-sc
  resources:
    requests:
      storage: 10Gi
EOF

kubectl apply -f test-pvc.yaml
kubectl get pvc
# Should show Bound status

# Clean up
kubectl delete -f test-pvc.yaml
```

---

### Step 4: Optional - Enable EFS CSI Driver

```bash
# Edit terraform.tfvars
# Set: enable_efs_csi_driver = true

# Apply changes
terraform apply

# Verify EFS CSI is running
kubectl get deployment -n kube-system efs-csi-controller
```

---

### Step 5: Install Additional Tools

#### AWS Load Balancer Controller

```bash
# Install Helm (if not already installed)
brew install helm  # macOS

# Add EKS chart repo
helm repo add eks https://aws.github.io/eks-charts
helm repo update

# Install AWS Load Balancer Controller
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=$(terraform output -raw eks_cluster_id)

# Verify
kubectl get deployment -n kube-system aws-load-balancer-controller
```

#### Metrics Server (for HPA)

```bash
# Install Metrics Server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Wait for deployment
kubectl rollout status deployment/metrics-server -n kube-system

# Test metrics
kubectl top nodes
```

---

## Cleanup

### Step 1: Delete K8s Resources

```bash
# Delete services
kubectl delete svc --all --all-namespaces

# Delete PVCs
kubectl delete pvc --all --all-namespaces

# Delete deployments
kubectl delete deployments --all --all-namespaces
```

---

### Step 2: Destroy AWS Resources

```bash
# WARNING: This deletes everything!

# Plan destroy
terraform plan -destroy -out=destroy.tfplan

# Review
terraform show destroy.tfplan

# Execute
terraform destroy

# Verify cleanup
aws eks list-clusters
```

---

## Essential Commands Reference

### Terraform

```bash
terraform init              # Initialize
terraform validate          # Validate syntax
terraform plan             # Preview changes
terraform apply            # Deploy
terraform destroy          # Delete all
terraform output           # Show outputs
TF_LOG=DEBUG terraform apply  # Debug
```

### kubectl

```bash
kubectl cluster-info       # Cluster info
kubectl get nodes          # List nodes
kubectl get pods -A        # All pods
kubectl describe node xxx  # Node details
kubectl logs pod-name      # Pod logs
kubectl top nodes          # Node metrics
```

### AWS CLI

```bash
aws eks list-clusters
aws eks describe-cluster --name cluster-name
aws eks list-addons --cluster-name cluster-name
aws logs tail log-group --follow
```

---

## Timeline

| Task | Duration |
|------|----------|
| Prerequisites | 30-60 min |
| VPC setup | 15 min |
| Terraform config | 15 min |
| terraform plan | 2 min |
| terraform apply | 20-30 min |
| Verification | 10 min |
| **Total** | **~2.5 hours** |

---

## Next Steps

1. Install Ingress Controller
2. Setup monitoring (Prometheus/Grafana)
3. Configure logging (CloudWatch/ELK)
4. Setup CI/CD (ArgoCD/Jenkins)
5. Configure RBAC
6. Network Policies
7. Pod Security
8. Backup strategy (Velero)

---

## Resources

- [AWS EKS Docs](https://docs.aws.amazon.com/eks/)
- [EKS Best Practices](https://aws.github.io/aws-eks-best-practices/)
- [Kubernetes Docs](https://kubernetes.io/docs/)
- [Terraform AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
