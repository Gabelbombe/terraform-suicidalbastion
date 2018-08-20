/** jumpbox instance */
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "jumpbox" {
  ami                                  = "${data.aws_ami.ubuntu.id}"
  availability_zone                    = "${var.default_az}"
  instance_type                        = "t2.micro"
  subnet_id                            = "${aws_subnet.public.id}"
  instance_initiated_shutdown_behavior = "terminate"

  vpc_security_group_ids = [
    "${aws_security_group.ehime.id}",
    "${aws_security_group.vpc_nat.id}",
    "${aws_security_group.ssh.id}",
  ]

  key_name = "${aws_key_pair.tf-deployment.key_name}"

  /* ensure that the nat instance and network are up and running */
  depends_on = ["aws_instance.nat", "aws_subnet.ehime"]

  provisioner "local-exec" {
    command = "echo  ${aws_instance.jumpbox.public_dns} > dns-info.txt"
  }

  /** copy the ehime key to the jumpbox */
  provisioner "file" {
    connection {
      user        = "ubuntu"
      host        = "${aws_instance.jumpbox.public_dns}"
      timeout     = "1m"
      private_key = "${file("~/.ssh/tf-deployment.pem")}"
    }

    source      = "~/.ssh/ehime-jumpbox.pem"
    destination = "/home/ubuntu/.ssh/ehime-jumpbox.pem"
  }

  /** copy the install script to the jumpbox */
  provisioner "file" {
    connection {
      user        = "ubuntu"
      host        = "${aws_instance.jumpbox.public_dns}"
      timeout     = "1m"
      private_key = "${file("~/.ssh/tf-deployment.pem")}"
    }

    source      = "ec2/install.sh"
    destination = "/home/ubuntu/install.sh"
  }

  /** execute the remote script */
  provisioner "remote-exec" {
    connection {
      user        = "ubuntu"
      host        = "${aws_instance.jumpbox.public_dns}"
      timeout     = "25m"
      private_key = "${file("~/.ssh/tf-deployment.pem")}"
    }

    inline = [
      "chmod +x install.sh",
      "./install.sh ${var.ehime_subnet_cidr} ${var.ehime_gw} ${var.ehime_ip} ${var.access_key} ${var.secret_key} ${aws_subnet.ehime.id} ${var.default_az} ${var.region} ~/.ssh/ehime-jumpbox.pem",
    ]
  }

  tags = {
    Name = "jumphost-vm"
  }
}
