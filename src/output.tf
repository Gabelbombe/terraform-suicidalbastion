output "jumpbox_ip" {
  value = "${aws_instance.jumpbox.public_ip}"
}

output "jumpbox_dns" {
  value = "${aws_instance.jumpbox.public_dns}"
}

output "ge_subnet_cidr" {
  value = "${var.ge_subnet_cidr}"
}

output "ge_gw" {
  value = "${var.ge_gw}"
}

output "ge_ip" {
  value = "${var.ge_ip}"
}

output "ge_subnet" {
  value = "${aws_subnet.ge.id}"
}
