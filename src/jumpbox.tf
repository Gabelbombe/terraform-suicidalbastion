/** jumpbox instance */
resource "aws_instance" "jumpbox" {
  ami                    = "${lookup(var.amis, var.region)}"
  availability_zone      = "${var.default_az}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.public.id}"
  vpc_security_group_ids = ["${aws_security_group.ge.id}", "${aws_security_group.vpc_nat.id}", "${aws_security_group.ssh.id}"]
  key_name               = "${aws_key_pair.tf-deployment.key_name}"

  /* ensure that the nat instance and network are up and running */
  depends_on = ["aws_instance.nat", "aws_subnet.ge"]

  provisioner "local-exec" {
    command = "echo  ${aws_instance.jumpbox.public_dns} > dns-info.txt"
  }

  /** copy the ge key to the jumpbox */
  provisioner "file" {
    connection {
      user        = "ubuntu"
      host        = "${aws_instance.jumpbox.public_dns}"
      timeout     = "1m"
      private_key = "${file("ssh/tf-deployment.pem")}"
    }

    source      = "ssh/ge.pem"
    destination = "/home/ubuntu/.ssh/ge.pem"
  }

  /** copy the install script to the jumpbox */
  provisioner "file" {
    connection {
      user        = "ubuntu"
      host        = "${aws_instance.jumpbox.public_dns}"
      timeout     = "1m"
      private_key = "${file("ssh/tf-deployment.pem")}"
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
      private_key = "${file("ssh/tf-deployment.pem")}"
    }

    inline = [
      "chmod +x install.sh",
      "./install.sh ${var.ge_subnet_cidr} ${var.ge_gw} ${var.ge_ip} ${var.access_key} ${var.secret_key} ${aws_subnet.ge.id} ${var.default_az} ${var.region} ~/.ssh/ge.pem",
    ]
  }

  tags = {
    Name = "jumphost-vm"
  }
}
