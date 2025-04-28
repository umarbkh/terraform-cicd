# Create ssh key pair
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create a key pair in AWS using the generated private key
resource "aws_key_pair" "this" {
  key_name   = "${var.project_name}-key"
  public_key = tls_private_key.this.public_key_openssh
}