# 🗄️ RDS Implementation Guide

Step-by-step guide for deploying the RDS module.

---

## Prerequisites

- Terraform >= 1.0 installed
- AWS CLI configured (`aws sts get-caller-identity` works)
- An existing VPC with at least 2 private subnets in different AZs
  (deploy `feature/vpc` first if needed)

---

## Step 1 — Clone & Switch Branch

```bash
git clone https://github.com/sujithp28/terraform-aws-infrastructure.git
cd terraform-aws-infrastructure
git checkout feature/rds
cd examples/rds
```

---

## Step 2 — Configure Variables

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars`. Minimum required values:

```hcl
vpc_id             = "vpc-0123456789abcdef0"
private_subnet_ids = ["subnet-aaa", "subnet-bbb"]
db_name            = "appdb"
master_username    = "admin"
master_password    = "YourStrongPassword123!"
```

**Tip**: Pass the password via environment variable to avoid storing it in a file:

```bash
export TF_VAR_master_password="YourStrongPassword123!"
```

---

## Step 3 — (Optional) Configure Remote State

```bash
cp backend.tf.example backend.tf
# Edit backend.tf with your S3 bucket and DynamoDB table
```

---

## Step 4 — Deploy

```bash
terraform init
terraform plan     # Review what will be created
terraform apply    # Type 'yes' to confirm
```

Typical deploy time: **5–10 minutes** (15–20 min for Multi-AZ).

---

## Step 5 — Verify

```bash
terraform output

# Connect to the DB
DB_HOST=$(terraform output -raw db_address)
mysql -h $DB_HOST -u admin -p appdb
```

---

## Upgrading Dev → Prod

1. Change `environment = "prod"` and increase `instance_class`
2. Set `multi_az = true`, `deletion_protection = true`, `skip_final_snapshot = false`
3. Run `terraform plan` — no data loss for these changes
4. Run `terraform apply` — Multi-AZ conversion takes ~10 minutes

---

## Destroying

```bash
# 1. Disable deletion protection first (if enabled)
terraform apply -var="deletion_protection=false"

# 2. Destroy
terraform destroy
```

---

## Troubleshooting

| Error | Fix |
|-------|-----|
| `InvalidSubnet` | Ensure subnets are in at least 2 different AZs |
| `InvalidParameterValue: engine version` | Check available versions: `aws rds describe-db-engine-versions --engine mysql` |
| `InsufficientDBInstanceCapacity` | Try a different AZ or instance type |
| `KMSKeyNotAccessibleFault` | Verify KMS key policy allows RDS access |
| Cannot connect after deploy | Check security group allows your app's SG or CIDR on the DB port |

Enable Terraform debug logging for deeper issues:
```bash
TF_LOG=DEBUG terraform plan 2>&1 | tee plan.log
```
