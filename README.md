Terraform infra

This folder contains Terraform modules and environment configurations for AWS infrastructure (VPC, ALB, ASG, Security Groups).

Environments:
- env/dev
- env/qa
- env/prod

Modules:
- modules/vpc
- modules/alb
- modules/asg

Use: `cd infra/env/dev && terraform init && terraform apply` (adjust `terraform.tfvars` per environment)
