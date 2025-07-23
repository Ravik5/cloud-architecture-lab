resource "aws_secretsmanager_secret" "this" {
  name                    = var.secret_name
  description             = var.description
  recovery_window_in_days = var.recovery_window_in_days
  kms_key_id              = var.kms_key_id

  dynamic "rotation_rules" {
    for_each = var.rotation_enabled ? [1] : []
    content {
      automatically_after_days = var.rotation_days
    }
  }

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_string
}

resource "aws_iam_role" "rotation" {
  count              = var.rotation_enabled ? 1 : 0
  name               = "${var.secret_name}-rotation-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.rotation_assume_role[0].json
  tags               = var.tags
}

data "aws_iam_policy_document" "rotation_assume_role" {
  count = var.rotation_enabled ? 1 : 0
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "rotation" {
  count      = var.rotation_enabled ? 1 : 0
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.rotation[0].name
}

resource "aws_iam_role_policy" "secret_access" {
  count  = var.rotation_enabled ? 1 : 0
  name   = "${var.secret_name}-secret-access"
  role   = aws_iam_role.rotation[0].name
  policy = data.aws_iam_policy_document.secret_access[0].json
}

data "aws_iam_policy_document" "secret_access" {
  count = var.rotation_enabled ? 1 : 0
  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:GetSecretValue"]
    resources = [aws_secretsmanager_secret.this.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:PutSecretValue"]
    resources = [aws_secretsmanager_secret.this.arn]
  }

  statement {
    effect    = "Allow"
    actions   = ["secretsmanager:DescribeSecret"]
    resources = [aws_secretsmanager_secret.this.arn]
  }
}

resource "aws_lambda_function" "rotation" {
  count            = var.rotation_enabled ? 1 : 0
  filename         = var.rotation_lambda_filename
  function_name    = "${var.secret_name}-rotation"
  role             = aws_iam_role.rotation[0].arn
  handler          = var.rotation_lambda_handler
  runtime          = var.rotation_lambda_runtime
  source_code_hash = filebase64sha256(var.rotation_lambda_filename)
  timeout          = var.rotation_lambda_timeout
  memory_size      = var.rotation_lambda_memory

  environment {
    variables = var.rotation_lambda_environment
  }

  tags = var.tags
}

resource "aws_lambda_permission" "rotation" {
  count         = var.rotation_enabled ? 1 : 0
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.rotation[0].function_name
  principal     = "secretsmanager.amazonaws.com"
}

resource "aws_secretsmanager_secret_rotation" "this" {
  count               = var.rotation_enabled ? 1 : 0
  secret_id           = aws_secretsmanager_secret.this.id
  rotation_lambda_arn = aws_lambda_function.rotation[0].arn

  rotation_rules {
    automatically_after_days = var.rotation_days
  }
}