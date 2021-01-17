variable "region" {
    type        = string
    description = "Region"
    default     = "us-east-1"
}

variable "env" {
    type        = string
    description = "Environment name"
    default     = "rocio"
}

variable "project" {
    type        = string
    description = "Project name"
    default     = "project"
}

variable "core_lambda_names" {
    type        = list(object({
      resource_name   = string
      source_file     = string
      filename        = string
      handler         = string
      runtime         = string
      timeout         = number
      environment     = list(object({
              variables = map(string)
      }))
    }))
    description = "Construct for dynamic lambdas core"
    default     = [
      {
        resource_name   = "lambda_core_1"
        source_file     = "lambda_core_1/app.py"
        filename        = "modules/lambda/lambda_code/lambda_core_1/app.zip"
        handler         = "app.lambda_handler"
        runtime         = "python3.8"
        timeout         = 600
        environment     = [{
          variables = {
            sqs_queue_url1 = "DateIteForHistLoadSQSFifoQueue"
            sqs_queue_url2 = "DateIteForHistLoadSQS2FifoQueue"
          }
        }]
      },
      {
        resource_name   = "lambda_core_2"
        source_file     = "lambda_core_2/app.py"
        filename        = "modules/lambda/lambda_code/lambda_core_2/app.zip"
        handler         = "app.lambda_handler"
        runtime         = "python3.8"
        timeout         = 600
        environment     = []
      }
    ] # End of object list
}
