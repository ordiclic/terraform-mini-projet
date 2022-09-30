resource "aws_ebs_volume" "volume" {
  availability_zone = var.az
  size              = var.size
  tags = {
    Name = "${var.project}-${var.stage}-additional"
  }
}
