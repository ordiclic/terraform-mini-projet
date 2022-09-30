variable "project" {}
variable "stage" {}

variable "ingress_ports" {
  type        = list(number)
  default     = [22, 80, 443]
  description = "Inbound ports to be allowed at VM creation (default: [22, 80, 443])"
}
