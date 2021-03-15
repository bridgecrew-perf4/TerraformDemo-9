output "demo-ec2-public-ip" {
  value = aws_instance.demo-instance.public_ip
}
