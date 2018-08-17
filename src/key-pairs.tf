/** key for deployment of jumpbox and nat */
resource "aws_key_pair" "tf-deployment" {
  key_name   = "tf-deployment"
  public_key = "${file("ssh/tf-deployment.pub")}"
}

/** key for ge */
resource "aws_key_pair" "ge" {
  key_name   = "ge-jumpbox"
  public_key = "${file("ssh/ge-jumpbox.pub")}"
}
