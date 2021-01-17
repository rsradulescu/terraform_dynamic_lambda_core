resource "aws_lambda_function" "core_lambda_function" {
  count = length(var.core_lambda_names)

  filename             = lookup(var.core_lambda_names[count.index], "filename")
  function_name        = lookup(var.core_lambda_names[count.index], "resource_name")
  role                 = aws_iam_role.iam_role_lambdacore.arn
  handler              = lookup(var.core_lambda_names[count.index], "handler")
  runtime              = lookup(var.core_lambda_names[count.index], "runtime")
  timeout              = lookup(var.core_lambda_names[count.index], "timeout")

    dynamic "environment" {
      for_each = var.core_lambda_names[count.index].environment
      content {
        variables  = environment.value.variables
      }
    }
}

#------------------------------------------------------
# IAM role - policy - policy_attachment
#------------------------------------------------------
resource "aws_iam_role" "iam_role_lambdacore" {
  name = "iam_role_lambdacore"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}
