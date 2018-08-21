/** key for deployment of jumpbox and nat */
resource "aws_key_pair" "deployment" {
  key_name   = "deployment"
  public_key = "${file("ssh/deployment.pub")}"
}

/** key for ehime */
resource "aws_key_pair" "ehime" {
  key_name   = "jumpbox"
  public_key = "${file("ssh/jumpbox.pub")}"
}
