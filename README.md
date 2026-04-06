# Backend Bootstrap (Terraform)

## Overview

This project is a **one-time setup** used to prepare your AWS account for future Terraform deployments.

By running this project, you will create:

- An S3 bucket to store Terraform state
- A DynamoDB table for state locking
- An IAM role with GitHub OIDC for secure CI/CD deployments

> ⚠️ You only need to run this project **once per AWS account**

---

## Why This Matters

In real-world DevOps workflows:

- Terraform state is stored remotely (not on your machine)
- Multiple deployments need safe locking to prevent conflicts
- CI/CD pipelines (GitHub Actions) need secure access to AWS

---

## What You Need to Update

### 1. GitHub Username / Organization

Open `variables.tf` and update:

```hcl
variable "github_org" {
  default = "your-github-username"
}
```

Replace with your GitHub username.

---

### 2. S3 Bucket Name

```hcl
variable "s3_bucket_name" {
  default = "rock-of-ages-terraform-state-your-initials"
}
```

Replace with a **globally unique name**.

> ⚠️ S3 bucket names must be globally unique

---

## What This Project Creates

### S3 Bucket
- Stores Terraform state
- Versioning enabled
- Encryption enabled

### DynamoDB Table
- Used for state locking

### GitHub OIDC IAM Role
- Enables secure GitHub Actions deployments

---

## How to Run Terraform

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

Type `yes` when prompted.

---

## Important Notes

- Run this project only once
- Do not delete these resources
- They will be used in future projects

---

## Summary

This project sets up the foundation for all future Terraform deployments in your AWS account.
