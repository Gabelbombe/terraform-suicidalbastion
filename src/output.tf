output "death_clock" {
  value = "${var.death_clock}"
}

output "jumpbox_ip" {
  value = "${aws_instance.jumpbox.public_ip}"
}

output "jumpbox_dns" {
  value = "${aws_instance.jumpbox.public_dns}"
}

output "ehime_subnet_cidr" {
  value = "${var.ehime_subnet_cidr}"
}

output "ehime_gw" {
  value = "${var.ehime_gw}"
}

output "ehime_ip" {
  value = "${var.ehime_ip}"
}

output "ehime_subnet" {
  value = "${aws_subnet.ehime.id}"
}
