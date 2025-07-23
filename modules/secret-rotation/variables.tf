variable "secret_name" {
  description = "Name of the secret"
  type        = string
}

variable "description" {
  description = "Description of the secret"
  type        = string
  default     = "Managed by Terraform"
}

variable "secret_string" {
  description = "The secret value"
  type        = string
  sensitive   = true
}

variable "recovery_window_in_days" {
  description = "Number of days that AWS Secrets Manager waits before it can delete the secret"
  type        = number
  default     = 30
}

variable "kms_key_id" {
  description = "KMS key ID to encrypt the secret with"
  type        = string
  default     = "alias/aws/secretsmanager"
}

variable "rotation_enabled" {
  description = "Whether to enable automatic rotation"
  type        = bool
  default     = true
}

variable "rotation_days" {
  description = "Number of days between automatic rotations"
  type        = number
  default     = 30
}

variable "rotation_lambda_filename" {
  description = "Path to the rotation Lambda function deployment package"
  type        = string
  default     = "rotation-lambda.zip"
}

variable "rotation_lambda_handler" {
  description = "Rotation Lambda function handler"
  type        = string
  default     = "index.handler"
}

variable "rotation_lambda_runtime" {
  description = "Rotation Lambda function runtime"
  type        = string
  default     = "nodejs14.x"
}

variable "rotation_lambda_timeout" {
  description = "Rotation Lambda function timeout in seconds"
  type        = number
  default     = 30
}

variable "rotation_lambda_memory" {
  description = "Rotation Lambda function memory size in MB"
  type        = number
  default     = 128
}

variable "rotation_lambda_environment" {
  description = "Environment variables for the rotation Lambda function"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}