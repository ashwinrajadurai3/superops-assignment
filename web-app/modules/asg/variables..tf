variable "vpc_security_group_ids" {}

variable "aws_lb" {}

variable "aws_key" {}

variable "private_subnet_id" {}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "alb_target_group_arn" {}