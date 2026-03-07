output "ec2_dns" {
  value = aws_instance.app_instance.public_dns
}