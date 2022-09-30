#Ecrivez un module pour créer une instance ec2 utilisant la dernière version de amazon linux 2 (qui s’attachera l’ebs et l’ip publique) dont la taile et le tag seront variabilisés

data "aws_ami" "amazon-latest" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.amazon-latest.id
  key_name               = "${var.project}-${var.stage}"
  instance_type          = var.instance_type
  vpc_security_group_ids = ["${var.sg.id}"]
  availability_zone      = var.az
  tags = {
    Name = "${var.project}-${var.stage}"
  }

  root_block_device {
    volume_size = var.size
    tags = {
      Name = "${var.project}-${var.stage}-root"
    }
  }

  connection {
    type        = "ssh"
    user        = var.username
    timeout     = "60s"
    private_key = file("${var.key_file}")
    host        = self.public_ip # Uses the IP address given *before* attaching the EIP
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
    ]
  }
}


resource "aws_eip_association" "eip_association" {
  instance_id   = aws_instance.ec2.id
  allocation_id = var.eip.id
}


resource "aws_volume_attachment" "secondary-volume" {
  device_name = "/dev/sdb"
  instance_id = aws_instance.ec2.id
  volume_id   = var.ebs.id
}


resource "local_file" "variable_outputs" {
  filename = "ip_ec2.txt"
  content  = "${var.eip.ip}\n"
}
