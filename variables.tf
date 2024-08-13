variable "region" {
  description = "AWS region"
  default     = "us--2"
}

variable "instance_count" {
  description = "Number of instances to launch"
  default     = 10
}

variable "key_name" {
  description = "key pair for ec2"
  type = string
  default     = "terraform"
}
