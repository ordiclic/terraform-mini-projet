variable "project" {}
variable "stage" {}

variable "instance_type" {
  type        = string
  default     = "t2.nano"
  description = "EC2 VM instance type"
}

variable "size" {
  type        = number
  default     = 8
  description = "Size of the instance root partition in GB (default: 8)"
}

variable "username" {
  type        = string
  default     = "ec2-user"
  description = "Default username of the instance (default: ec2-user)"
}

variable "sg" {
  description = "Security group object to attach to the instance"
}

variable "eip" {
  description = "EIP object to attach to the instance"
}

variable "ebs" {
  description = "EBS object to attach to the instance"
}

variable "key_file" {
  type        = string
  description = "Path to the private key to use to connect to the instance during setup"
}

variable "az" {
  type        = string
  description = "Availability zone of the instance"
}
