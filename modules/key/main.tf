resource "tls_private_key" "private-key" {
  count     = 1
  algorithm = "RSA"
  rsa_bits  = 4096
}


resource "aws_key_pair" "generated_key" {
  count      = 1
  key_name   = "${var.project}-${var.stage}"
  public_key = tls_private_key.private-key[0].public_key_openssh
}


resource "local_file" "private_key" {
  content         = tls_private_key.private-key[0].private_key_pem
  filename        = var.key_file
  file_permission = "0600"
}
