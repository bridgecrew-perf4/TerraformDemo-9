##################################################
# Resource - Keypairs -
##################################################
resource "aws_key_pair" "demo-keypair-pub" {
  key_name   = "demo-keypair.pub"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDP/BJWoNBxE1RjrLM/4VQMV3Bjclv15bKpj4zMiuQfXxEHO6131IIvjIWyWDwo1VOEGHc5qZ52b1JEyaUHJpf7ElitdWuD6NHfBAYwuXK/kXLa0+oa4yYWvhEeqXazM0/CgN+sC9cUMBg8KYLRYyDdOLDNQdWCtQCebkGWWahzt1flDVq/1wef1FP4Rx6itgjajxOv048E7kc17W/A8Liv//Bmv/pR49u1j7DekxYORY8YppOOdIpO46uiQMo8DB9WWSk5UP0KA4wL06LtB3wNYdZF+EVegm4Q9vBQmjvkW5XezprWbChvmjLQ7ng9XNC9mhhHnwg3uytGVZN4sUr3 DEMO"

  tags = {
    Name = "${local.environment}-keypair"
    Env  = local.environment
  }
}

##################################################
# Resource - AMI -
##################################################
data "aws_ami" "demo-ami" {
  owners = ["self"]
  filter {
    name = "tag:Name"
    values = [
      "demo-amzn2-nginx"
    ]
  }
}

##################################################
# Resource - EC2 -
##################################################
resource "aws_instance" "demo-instance" {
  ami           = data.aws_ami.demo-ami.id
  instance_type = var.demo-instance-type
  subnet_id     = aws_subnet.demo-subnet.id
  vpc_security_group_ids = [
    aws_security_group.demo-security-group.id
  ]
  key_name = aws_key_pair.demo-keypair-pub.key_name
  tags = {
    Name = "${local.environment}-ec2"
    Env  = local.environment
  }
}
