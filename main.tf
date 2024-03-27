resource "aws_sns_topic" "billing" {
  name = var.sns_topic_name
}

resource "aws_sqs_queue" "billing" {
  name                      = var.sqs_queue_name
  delay_seconds             = var.sqs_queue_delay_seconds
  max_message_size          = var.sqs_queue_max_message_size
  message_retention_seconds = var.sqs_queue_message_retention_seconds
  receive_wait_time_seconds = var.sqs_queue_receive_wait_time_seconds
}

resource "aws_sns_topic_subscription" "billing_sqs_target" {
  topic_arn = aws_sns_topic.billing.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.billing.arn
}

resource "aws_sqs_queue_policy" "billing" {
  queue_url = aws_sqs_queue.billing.id

  policy = jsonencode(
    {
      Version : "2012-10-17",
      Id : "sqspolicy",
      Statement : [
        {
          Sid : "First",
          Effect : "Allow",
          Principal : "*",
          Action : "sqs:SendMessage",
          Resource : aws_sqs_queue.billing.arn,
          Condition : {
            ArnEquals : {
              "aws:SourceArn" : aws_sns_topic.billing.arn,
            },
          },
        },
      ],
    }
  )
}