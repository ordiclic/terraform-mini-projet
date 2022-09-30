resource "aws_security_group" "allowed_inbound" {
  name        = "${var.project}-${var.stage}"
  description = "Allow inbound traffic on some ports (default: 22, 80, 443) for project ${var.project} (${var.stage})"
  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = port
    content {
      description      = "TLS from VPC"
      from_port        = port.value
      to_port          = port.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.project}-${var.stage}"
  }
}
