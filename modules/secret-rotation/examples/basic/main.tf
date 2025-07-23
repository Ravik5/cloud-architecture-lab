module "database_secret" {
  source = "../../modules/secret-rotation"

  secret_name = "prod/database/credentials"
  description = "Database credentials for production environment"
  secret_string = jsonencode({
    username = "dbadmin"
    password = "supersecretpassword"
  })

  rotation_enabled = true
  rotation_days    = 7

  rotation_lambda_filename = "${path.module}/lambda/rotation.zip"
  rotation_lambda_handler = "index.handler"
  rotation_lambda_runtime = "nodejs14.x"

  tags = {
    Environment = "production"
    Terraform   = "true"
  }
}