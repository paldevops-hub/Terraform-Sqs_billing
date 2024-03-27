variable "sns_topic_name" {
  type        = string
  description = "Name of the SNS topic"
  default     = "billing"
}

variable "sqs_queue_name" {
  type        = string
  description = "Name of the SQS queue"
  default     = "billing"
}

variable "sqs_queue_delay_seconds" {
  type        = number
  description = "Delay time for messages in the SQS queue"
  default     = 90
}

variable "sqs_queue_max_message_size" {
  type        = number
  description = "Maximum size of messages in the SQS queue"
  default     = 2048
}

variable "sqs_queue_message_retention_seconds" {
  type        = number
  description = "Time to retain messages in the SQS queue"
  default     = 86400
}

variable "sqs_queue_receive_wait_time_seconds" {
  type        = number
  description = "Wait time for receiving messages from the SQS queue"
  default     = 10
}