
# Secrets Rotation Module 

```markdown
# Terraform AWS Secrets Manager Rotation Module

A Terraform module for implementing secure secret storage with automatic rotation in AWS Secrets Manager.

## Features

- 🔄 **Automatic Rotation**: Configurable rotation schedule
- 🔐 **Encryption**: KMS encryption support
- 🛡️ **IAM Controls**: Least-privilege access policies
- λ **Lambda Integration**: Built-in rotation function setup
- 🗓️ **Versioning**: Secret version tracking

## Usage

```hcl
module "rds_credentials" {
  source = "git::https://github.com/Ravik5/cloud-architecture-lab.git//modules/secret-rotation?ref=v1.0.0"

  secret_name    = "prod/rds/credentials"
  secret_string  = jsonencode({
    username = "admin",
    password = "initial-password"
  })

  rotation_enabled          = true
  rotation_days             = 15
  rotation_lambda_filename  = "lambda/rotation.zip"
  rotation_lambda_handler   = "index.handler"

  tags = {
    Application = "order-service"
    Critical    = "true"
  }
}