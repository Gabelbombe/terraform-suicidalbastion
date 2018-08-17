/** key for deployment of jumpbox and nat */
resource "aws_key_pair" "tf-deployment" {
  key_name   = "tf-deployment"
  public_key = "${file("~/.ssh/tf-deployment.pub")}"
}

/** key for ehime */
resource "aws_key_pair" "ehime" {
  key_name   = "ehime-jumpbox"
  public_key = "${file("~/.ssh/ehime-jumpbox.pub")}"
}
