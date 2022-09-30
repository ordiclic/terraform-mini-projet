variable "project" {}

variable "stage" {}

variable "az" {
  type        = string
  description = "Availability zone of the EBS"
}

variable "size" {
  type        = number
  default     = 5
  description = "Size of the created secondary volume in GB (default: 5)"
}
